Return-Path: <netdev+bounces-297385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S0QgK1i+KGq4IwMAu9opvQ
	(envelope-from <netdev+bounces-297385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:31:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2301D665394
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:31:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dDv9bjH3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297385-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297385-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B53E030C4279
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F384527CB02;
	Wed, 10 Jun 2026 01:30:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D8283C89
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:30:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055020; cv=none; b=eRjwwDuGYb9SnXaPisMYeOJb/cbSk5DlNgztbvZcWX1qliu9JoueikQscybdZA3UrfqCzQINkaLMSUgLPTVzNZ7msVoZd5xmPP1GHo938VX7kDnhAAdkKXsGLHDdinqQy1dhFPVAnMa/T7qita34AxBv/xwUlAJ75C+pauryMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055020; c=relaxed/simple;
	bh=Yu50h+5KdmI5E+k25xvnfbBwM19gr/sgCj1mpwTTwKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaX4jGw4zuv4bGfQCYAz3cuPRkJtk2cCl55XXlxZUhKlQrEJ3lEkLvjl+6T7UbC1ayEsTHiMPzr5+8njuuou+7LUCSNwbEcfqtryhpfkjAlPlKyedFy2rTIoPkuydVo6osf6ryIgHKSlUZ7grltbKVW3h8qcjHOXt1kSIVHUPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDv9bjH3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0251F00893;
	Wed, 10 Jun 2026 01:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781055019;
	bh=vnjj5xwzvzivpvmbEwsldfdmWzi3yTibzkYnST9A/1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dDv9bjH30iEpFXGPyItMaoK97lwtTNs9JubunePeRNqYUD5ibX/f0ZMsv/vMfEsIh
	 0IvTAOJOQN93UWyU+jckLzt9y88iUVVBB8VRm9ur5YheC7BHKwki7F7r1ZuMIdyuGd
	 wH8g1zJUJzNXyXa88sY/Ny+ohiHWmp1/Ms5YPhCjRyWFjKm+slTe1+Ovj6eKb6o5cK
	 dxbRdciVXS4m9Bjn28Qb7Q+TtRBQ9N9g8Lxf8BHlTWfsR0fayVMMBLVlIvazfUK647
	 C0p4n7EhNzG+Obhsg7HJJRyqOOTM6EPJEkWkcfYmMZQzBgh3JVVuk3/IY9qAp+ivb2
	 5VBVeHqu2EYtA==
Date: Tue, 9 Jun 2026 18:30:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, davem@davemloft.net, yotam.gi@gmail.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bestswngs@gmail.com
Subject: Re: [PATCH net] psample: zero the netlink attribute padding in
 PSAMPLE_ATTR_DATA
Message-ID: <20260609183018.1764046d@kernel.org>
In-Reply-To: <20260607031640.2743713-1-xmei5@asu.edu>
References: <20260607031640.2743713-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297385-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:yotam.gi@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:yotamgi@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,gmail.com,google.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2301D665394

On Sat,  6 Jun 2026 20:16:40 -0700 Xiang Mei wrote:
> psample_sample_packet() open-codes the PSAMPLE_ATTR_DATA attribute.
> It reserves nla_total_size(data_len) bytes via skb_put() but only writes
> NLA_HDRLEN + data_len of them, so when data_len is not a multiple of 4 the
> up to 3 trailing alignment-padding bytes are left uninitialised.  The skb
> head comes from kmalloc_reserve(), which does not zero memory, so those
> bytes hold stale slab contents that are then broadcast to all listeners on
> the PSAMPLE_NL_MCGRP_SAMPLE multicast group, leaking kernel heap memory to
> userspace.
> 
> Zero the trailing padding after the payload copy.
> 
> Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/psample/psample.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 7763662036fb..26220dca0f12 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -485,6 +485,9 @@ void psample_sample_packet(struct psample_group *group,
>  
>  		if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
>  			goto error;
> +
> +		memset((unsigned char *)nla + nla->nla_len, 0,
> +		       nla_padlen(data_len));
>  	}
>  
>  #ifdef CONFIG_INET

Could you see if this diff works? I think it's slightly cleaner:


 diff --git a/net/psample/psample.c b/net/psample/psample.c
index 7763662036fb..c112e1f0ccac 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -476,15 +476,17 @@ void psample_sample_packet(struct psample_group *group,
                goto error;
 
        if (data_len) {
-               int nla_len = nla_total_size(data_len);
+               int nla_len = nla_attr_size(data_len);
                struct nlattr *nla;
 
                nla = skb_put(nl_skb, nla_len);
                nla->nla_type = PSAMPLE_ATTR_DATA;
-               nla->nla_len = nla_attr_size(data_len);
+               nla->nla_len = nla_len;
 
                if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
                        goto error;
+
+               skb_put_zero(nl_skb, nla_padlen(data_len));
        }

 #ifdef CONFIG_INET

