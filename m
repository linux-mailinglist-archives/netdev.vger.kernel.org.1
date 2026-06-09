Return-Path: <netdev+bounces-296934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id og2hH1O/J2rv1QIAu9opvQ
	(envelope-from <netdev+bounces-296934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:22:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D918E65D26B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:22:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=aTuKoJRJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296934-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296934-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6378E3062979
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7BF3B19D1;
	Tue,  9 Jun 2026 07:19:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B384386C39
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 07:19:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989596; cv=none; b=a0sUhX2XX8OcJopU49px9X3JdIvoSqJWLabvdHU/zFSo3OBJLTDzJXQWOZZCWGni4rkrnVTg/a/vzAd7U/Tg1kKkQU/CNvUXg/pNnNWWaPB1V1uzbC42o9aJuLLc6xOoC2S1eOxigzbE2uec1FqwDt6IhkndNJoF8oL/loTU4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989596; c=relaxed/simple;
	bh=ZQsIwAc4TK4gYJhywJsUtBBFirKBKx79iCXRGMA/tu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eF78QQzfUDnbzKah2skqcsEKl0WhRNoilnlWiWLuMDkqFjd7qzzVwLkTJsK70TaM5uHkhNu7nOeUoSbyxgge0gDf0peDXCTVF7YNlwvaVNifn9MvinVtRUQB9PC5x4ZZF4TLuXIFKnV17o5WNXIB6v35NiqA96oIMV03uZL2xCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=aTuKoJRJ; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b3637b90so44168165e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780989594; x=1781594394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q05dmcAqN63nW0f7el0pgdqxr4o+7V51VBgIj7r5oDc=;
        b=aTuKoJRJjYFBh583cnCQ4F2q+eYmRIAYU0pS02BNclPg0PwgoEd40zmKUPjviukBWZ
         7adf7tL99TAl4CfJO401ALMikHsGCkNrzusZ0fMY35z9P7K5Bn1IBYwnhG8ttmRYs9Vh
         soCWcJ0+BypBmBECWL2v605Qc167o9JavOsxUuniDUhGKu13qzyvjDHygCkaVS8xhvyV
         2oaR0poCJAoMyyRGjB+OIxhlfaIGLsm7TNc09kpoGn/NvvH5Dazs1Dmm5/pF4Z05NRCY
         MAPJVDAECMQlWBbQn57CUspJe/VkqnLg/XW3mXr9r5gU/UfIsFl/oEv4DJ/SA48EuTKT
         TexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780989594; x=1781594394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q05dmcAqN63nW0f7el0pgdqxr4o+7V51VBgIj7r5oDc=;
        b=I3dvhx3dOYDR7GoMubVr1v1DeNz1fOi398FdgqgUdlmexJ/QDxJIv6pqrZYOeCw1SC
         Hb10tmw/P6n7goIOrdKhHZDRHQ9GC0K+N2ssF763zICtQCbC/7lBT6Diy7eOye9CEMqb
         Lu0PZEwZlZdmxxsnTUmSE8AqBM590X9y61NMudAQpr78TRv9hOOfCdhoTmYHwY1j2imW
         Sc5VoasA4in7rzL69s1lEWnyHQIfjpkrBWmPy2eP2AsbVteNEbvOqu4h5HeJm+hQMcu2
         jS3BFWj+T3eutDgDoUT82DpTb92b7N0RAUcA+Bk+wxQmYMjarPwRPF3Uu/pwfNolbJcp
         7Kcw==
X-Forwarded-Encrypted: i=1; AFNElJ/J0hedoHmAsgxqkFjW/3X5Kam4FeI9wM8zmVlkwgHdQ2ZhdYTYmvxnp0e+aEh50HefID0T750=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvrKTa4a9MOCVCyrLeBxhIcyfgGWOCcjkG6JP+PiyntU4tqUr
	eu9n6dHjEEOy+xP8xoJ+dtaYcYulteQwlZ8yZJcIEpLfLybbKs0DdbVj6ObrTL3L5bI=
X-Gm-Gg: Acq92OGCZFy02ORQvlIVT5Wpn7RsL+7EOe7wLKsiulujkR+sX9RVORWE9DGzHKKc9Os
	HbEb9hj9U3PUC1sLmpbfgdc0MwIFmI8kf/lrR6up74ZzQpyMjXFTui8j/bmmlAFD6vd8WRNXfhg
	8pLCGS2gBBbVPPSfXA5yUs3NfEbEVjA7FQiDuxKMa7IwCF0vXdJTz24SEnV5Ht8h598cVhUGRek
	D0/P0oYGXNLeVqKm7BvFYfGbKcrqW4TzQWEPZbR6xs9uDxYRXeHmX/58Ekq0oNomN3fNyQSm9Ur
	/oVJujMZZ3TRoNU5OZ+CW4ViTOIdXTjO4poWRh8WqTfWFx/mwV1f8mG9fqGeLllaEx29aty4Vfz
	kZ8oCsiHlXwe4l1XO2cJsb1eusMgs9Z3h46zKK5f7ezNo1ZoEyprWKCh6JTWcQxyVj0LOrciGwk
	0QPy91XqoIEdboJ4FhMqnE3d9axb+0SzIcoD13Ypv9cJvepcfvokfdv5FXKcNgKtqF
X-Received: by 2002:a05:600c:198d:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-490c25baa0bmr318874635e9.14.1780989593720;
        Tue, 09 Jun 2026 00:19:53 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm494097605e9.14.2026.06.09.00.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 00:19:53 -0700 (PDT)
Message-ID: <7fb9fef9-919c-47e5-94ab-bdfc42849104@blackwall.org>
Date: Tue, 9 Jun 2026 10:19:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] bridge: cfm: reject invalid CCM interval at
 configuration time
Content-Language: en-US, bg
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, horms@kernel.org, bridge@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bestswngs@gmail.com
References: <20260609065116.2818837-1-xmei5@asu.edu>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260609065116.2818837-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lists.linux.dev,davemloft.net,google.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296934-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:idosch@nvidia.com,m:horms@kernel.org,m:bridge@lists.linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D918E65D26B

On 09/06/2026 09:51, Xiang Mei wrote:
> ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> the configured exp_interval converted by interval_to_us(). When
> exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> interval_to_us() returns 0, causing the worker to fire immediately in
> a tight loop that allocates skbs until OOM.
> 
> Fix this by validating exp_interval at configuration time:
> 
>   - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid range
>     [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
>     netlink policy so userspace cannot set an invalid value.
> 
>   - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
>     not yet been configured (defaults to 0 from kzalloc).
> 
> Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v4: remove the Suggested-by tag
> v3: Correct the fix tag and avoid use magic numbers
> v2: Move validation out of the datapath and into configuration
> 
>   net/bridge/br_cfm.c         | 6 ++++++
>   net/bridge/br_cfm_netlink.c | 4 +++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index 118c7ea48c35..dea56fffa1c1 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c
> @@ -805,6 +805,12 @@ int br_cfm_cc_ccm_tx(struct net_bridge *br, const u32 instance,
>   		goto save;
>   	}
>   
> +	if (!interval_to_us(mep->cc_config.exp_interval)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Invalid CCM interval");
> +		return -EINVAL;
> +	}
> +
>   	/* Start delayed work to transmit CCM frames. It is done with zero delay
>   	 * to send first frame immediately
>   	 */
> diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
> index 2faab44652e7..91b9922dc3f2 100644
> --- a/net/bridge/br_cfm_netlink.c
> +++ b/net/bridge/br_cfm_netlink.c
> @@ -34,7 +34,9 @@ br_cfm_cc_config_policy[IFLA_BRIDGE_CFM_CC_CONFIG_MAX + 1] = {
>   	[IFLA_BRIDGE_CFM_CC_CONFIG_UNSPEC]	 = { .type = NLA_REJECT },
>   	[IFLA_BRIDGE_CFM_CC_CONFIG_INSTANCE]	 = { .type = NLA_U32 },
>   	[IFLA_BRIDGE_CFM_CC_CONFIG_ENABLE]	 = { .type = NLA_U32 },
> -	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] = { .type = NLA_U32 },
> +	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] =
> +		NLA_POLICY_RANGE(NLA_U32, BR_CFM_CCM_INTERVAL_3_3_MS,
> +				 BR_CFM_CCM_INTERVAL_10_MIN),
>   	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID]	 = {
>   	.type = NLA_BINARY, .len = CFM_MAID_LENGTH },
>   };

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


