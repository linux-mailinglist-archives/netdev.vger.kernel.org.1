Return-Path: <netdev+bounces-285277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CtUFhh4/Gm3QQAAu9opvQ
	(envelope-from <netdev+bounces-285277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:31:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF69F4E7851
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41C3C300E3C5
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9193D9054;
	Thu,  7 May 2026 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9W2MlY6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ogJ63FRd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC733B6DB
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153493; cv=none; b=kz8Ks9OVCEUN5z8SDhJppc5Lko2cSjAxcwIFyq/HBmiVROtuegPwKhgCJskShsqn9AvcpHVzKXYBW3Mj2g0gpPE8gCxbmnTc4H7UC/0SREmXOg77oTifJJyFwUHcXKXPe5rSnNoaG9Vuo7qT6yJrXO58dD0D7b1wX91cJGmLb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153493; c=relaxed/simple;
	bh=cyiYGy1gEv+iXflgXx44xNGEmkBTXcFw6mlOVf+LM8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BK6XkSp6i0kM6hMVGbq8vRsXvWoBucyhJYC48hXLSpvSoYTX8UXnr5Y5iXDt6kqyVJfAtMVYVSx901l+3j5gmOvaQW6JzEKcMWOvmn7Gbq0AAgYMXVLAjUwbsSlh6hx/i68YCBL4fsHhvZ1e4V7uOlOAqBBykD8e7i7IGlEVghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9W2MlY6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ogJ63FRd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778153490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BomrRhKMx3+Q9j/dmB0a3mhqfb+BMVARxbi6baHw+i4=;
	b=A9W2MlY67A/66xZDLUnw9ulTsbc1tNGb8W6u9sJnPzougxGo4IjMAf9e0FypYeHSM5ylP9
	ufSX2flS/Fy24QRgsEe2ZBYjKTOXNbvbtRfM8nsTQDbA6FyGSyKkmTxwWqclVGfawFtPsV
	zVpt2vqDAppYsKTSAQwe9Dryj5sPK6c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-G_FTD6_qOs6q6UA-9pkylw-1; Thu, 07 May 2026 07:31:29 -0400
X-MC-Unique: G_FTD6_qOs6q6UA-9pkylw-1
X-Mimecast-MFC-AGG-ID: G_FTD6_qOs6q6UA-9pkylw_1778153488
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d1bc85bb3so3165205e9.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 04:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778153488; x=1778758288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BomrRhKMx3+Q9j/dmB0a3mhqfb+BMVARxbi6baHw+i4=;
        b=ogJ63FRdHExcP0QnggXEc4JtQuAaM3FrEQax8VRq4wItnJh7jt89ASleR9JqEd5E1d
         6fKBEtdBZ7Mwd8K2TJ8JbjZ5KiMZguk7dnDaPziv/BE2tXuTKT6FHFiE+Ejq+wWF+o0R
         P89Ve+wq1ks6vsU0u1pmiqW0wL/TXPrb5RGbn+6IpxSVra0aoHRWZqcXL4WftmGC2SG8
         6dLMje0IY0upT8bzatjdnNBTqs9k5ck+fOF6+P6E1C8vV/ePskvrM9bJnWPSdUVPAS7Q
         TRobEb74JtYW7opSVe+HxVCTu77aKvxLhfKslgJ35I826DojSXgnCjaAACmTC+ql4Muh
         6I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778153488; x=1778758288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BomrRhKMx3+Q9j/dmB0a3mhqfb+BMVARxbi6baHw+i4=;
        b=gzviIc0wA0QCJPBW/EKEv4Yv4hptYXU9+2VBFmX8TpqHxCJolxTrDhxt/mXF+310Cl
         ZJW60YkzmqMH8zrigQp4kvOMoU4C0HTIpNHTbWjRW860Pgc5lmTL/7spi2itWG4McB4r
         UYZ1KyssCg0wtKwM2YB0yx/lb2K3G5iEuHjMcihxi0cBTLYkunP/Bq6YUSylNT5SouJz
         BEly4v0eRVXM9TB4ochJu6hn1bxk59vvfIp7kgvzyhPh46dR5EjvDtJtBZkadxsNa2qm
         LMadgSMRcswTW3s9nfTWHKcmaVXME5jU2mHQTzL6B3YdVOJbgkIJSXa7CBqFThPpkZe0
         7oXw==
X-Forwarded-Encrypted: i=1; AFNElJ92TRoZXdaMA3u4FyuKyuZbxBbSn8ecEgtSbq25e2nvpF7E3/ucmz8VKuExbnRshGVAlMjV6qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHD7P6pdUYg9XPA8VZjFv8y8+O3wkrPOPY3MF9AGsvqaF0jLCn
	gG3mGV0CI7GW81sbyDoCNerqysY8qadF7hfUt5Ru7RF0tbSX3cnoM3LZJEFcvRa8dR+PCqc1Cti
	3gjkIcyRq6vG9RCi0olDHIdzz8Yw08Vx9a08FNMzI4ZzNajAx1NdLVVbUeA==
X-Gm-Gg: AeBDieuZmtvsBATNw9+BW1e5VcBQ5eNOzKhBxxkeyuv46K2mZ7ywkHloVEyYBaPhvaG
	OLqhibmdKm15YghkQlBMf8AIp4gHskGhEQcBF9fFDQHhBdEDhh8B3yRZLaGs2GyE6w2RumxCK1f
	gyexkp9y/56ynCtzcG/iNEJmWecMRvLQ33UMdf1Tx0xGoiZ10gh/1ztxtA4agI+XSMxnnVQViD/
	svKHmkNTdprQkOxI2amHVo3SyLQ0hU/uDbyOlxNuOuUXB+IBiOPNCHZQZfQ/wsYr3Fj1Ie+5dRd
	WofiV/NcvhoSSlHyBKw6dDyH1zzcScN0mfFqVJPC4PYYEPDuQTFyfcTUob3qBTtmLBp72ww0nBk
	ou+hWIpEULQc48Ag9/clCopkJYOEgazzFXX4qibXkIwaMlLVl6Ye1qefRb3m0oinbG8DiAMlVDz
	A/
X-Received: by 2002:a05:600c:4749:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48e5df8d7a7mr35210305e9.0.1778153487430;
        Thu, 07 May 2026 04:31:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4749:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48e5df8d7a7mr35209555e9.0.1778153486685;
        Thu, 07 May 2026 04:31:26 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53895effsm114434365e9.3.2026.05.07.04.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 04:31:26 -0700 (PDT)
Message-ID: <b1820863-fd30-45b5-b03e-28225ea80780@redhat.com>
Date: Thu, 7 May 2026 13:31:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: openvswitch: decouple flow_table
 from ovs_mutex
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: aconole@redhat.com, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "open list:OPENVSWITCH"
 <dev@openvswitch.org>, open list <linux-kernel@vger.kernel.org>
References: <20260505084253.998548-1-amorenoz@redhat.com>
 <20260505084253.998548-3-amorenoz@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260505084253.998548-3-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BF69F4E7851
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285277-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/5/26 10:42 AM, Adrian Moreno wrote:
> In order to protect flow operations from RTNL contention, this patch
> decouples flow_table modifications from ovs_mutex by means of the
> following:
> 
> 1 - Create a new mutex inside the flow_table that protects it from
> concurrent modifications.
> Putting the mutex inside flow_table makes it easier to consume for
> functions inside flow_table.c that do not currently take pointers to the
> datapath.
> Some function signatures need to be changed to accept flow_table so that
> lockdep checks can be performed.
> 
> 2 - Create a reference count to temporarily extend rcu protection from
> the datapath to the flow_table.
> One reference is held by the datapath, the other is temporarily
> increased during flow modifications.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  net/openvswitch/datapath.c   | 230 ++++++++++++++++++++++-------------
>  net/openvswitch/flow.c       |  13 +-
>  net/openvswitch/flow.h       |   9 +-
>  net/openvswitch/flow_table.c | 173 ++++++++++++++++----------
>  net/openvswitch/flow_table.h |  53 +++++++-
>  5 files changed, 318 insertions(+), 160 deletions(-)

This is still considerably big. I'm wondering if introducing the
lockdep_ovs_tbl_is_held/rcu_dereference_ovs_tbl annotations with a
separate earlier patch would make it more palatable? Just a very wild
guess; if the result is ugly (or you have string feeling that would be)
please ignore.

> @@ -1112,7 +1132,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
>  						       ufid_flags);
>  			BUG_ON(error < 0);
>  		}
> -		ovs_unlock();
> +		mutex_unlock(&table->lock);
> +		ovs_flow_tbl_put(table);

Minot nit: you can consolidate 2 ovs_flow_tbl_put() calls after the
if/than/else statement.

@@ -524,9 +540,22 @@ void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
>  	call_rcu(&mc->rcu, mask_cache_rcu_cb);
>  	call_rcu(&ma->rcu, mask_array_rcu_cb);
>  	table_instance_destroy(ti, ufid_ti);
> +	mutex_destroy(&table->lock);
>  	kfree(table);
>  }
>  
> +void ovs_flow_tbl_put(struct flow_table *table)
> +{
> +	if (refcount_dec_and_test(&table->refcnt)) {
> +		mutex_lock(&table->lock);
> +		table_instance_flow_flush(table,
> +					  ovs_tbl_dereference(table->ti, table),
> +					  ovs_tbl_dereference(table->ufid_ti, table));
> +		mutex_unlock(&table->lock);

As mentioned in the previous patch you can follow-up moving here the

	call_rcu(&mc->rcu, mask_cache_rcu_cb);
 	call_rcu(&ma->rcu, mask_array_rcu_cb);

currently in ovs_flow_tbl_destroy_rcu.

> +/* Must be called with flow_table->lock held. */
>  int ovs_flow_tbl_flush(struct flow_table *flow_table)
>  {
>  	struct table_instance *old_ti, *new_ti;
>  	struct table_instance *old_ufid_ti, *new_ufid_ti;
>  
> +	ASSERT_OVS_TBL(flow_table);

Minor nit: adding the assert and the comment is redundant. I think the
assert alone would be better. There are other similar later occurrences.

/P


