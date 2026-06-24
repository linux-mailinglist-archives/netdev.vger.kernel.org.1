Return-Path: <netdev+bounces-301527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uwWaNek9O2rSUAgAu9opvQ
	(envelope-from <netdev+bounces-301527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:16:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C86BAE17
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:16:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mq8FTgzX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301527-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301527-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B49283072F4C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 02:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D44E2F25F5;
	Wed, 24 Jun 2026 02:15:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6F2F1FC3
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:15:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267350; cv=none; b=s1pobudHlsWLMqAvgSm/AIRcQ3RgPFoQlXcla74in229L3wX8KTBogX9epSlMsaBrvpJMntxspHO+HKHj54VBx4A61HLaewPmQtW+SUxDrDlW5cpcCRkvEKqR2Tf6OjK3u9IEVwFgl/BLyuLFVOtlY4hPaU/TKw66KUdPcBIDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267350; c=relaxed/simple;
	bh=WFD5Nwr/6sQooh8nwnCIIY40JZK7X3R+osx/TslDHjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rS7KCQw+xggp5uiuQvGIyIvw9lQqSndAKUnZnytCtnnCCoNGBXtGMLDT7Y2kssko5H/Rn7junxHXnDOS6u3hVGxL6qrU3YCrQ8X5jdTdDtstfKgLSvUz4023nXzD4BFcvuKN2NkKmzJODr/ADDkmRd1jjYqWxcvqKwEtIehR9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq8FTgzX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7D51F000E9;
	Wed, 24 Jun 2026 02:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267349;
	bh=bKAh4onTVD8aLH0mT+VrU1Rg9O7dWv7OR1kZgW05FUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mq8FTgzXsq5/9lVbQtYWd7i+l/jVsIbanyHw+5w+zFZTCcdb5d4+rXo3SO1610pLy
	 PPHsh8kVbDyvCNhaneahiYHZ7ADbiohErCwcs3/fEOHEZvWxmawOjrtkoaIyHGXTo6
	 N3u03eI5QSQmsrJ5/bT70H1abvr3dhLrgQBt7UOkPyTqTVweXwmCsj9lUjKC6cOiMJ
	 8lElQJ5e6zUkhwbhDPT7hkqRwv+rmAaZtbwm1X0/6HN9GO2sReMKLq3CUTaSskKnqI
	 v0L43nooPyq8AI6fshlCqRqNcu2reKqRvZaHRGDovuZvXFG5RrmaOiAuW3e274Wyed
	 ukIxqrIrYZEog==
From: Jakub Kicinski <kuba@kernel.org>
To: linusw@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	hauke@hauke-m.de,
	kurt@linutronix.de,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	clement.leger@bootlin.com,
	george.mccollister@gmail.com,
	mmyangfl@gmail.com,
	netdev@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH net v4] net: dsa: Fix skb ownership in taggers
Date: Tue, 23 Jun 2026 19:15:46 -0700
Message-ID: <20260624021546.2131211-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622-dsa-fix-free-skb-v4-1-7aea01bf4036@kernel.org>
References: <20260622-dsa-fix-free-skb-v4-1-7aea01bf4036@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301527-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,broadcom.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E7C86BAE17

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: Fix skb ownership in taggers

This change reworks the DSA tagger ->xmit() and ->rcv() ownership rules
so that taggers consume the skb on failure rather than leaving the drop
to dsa_user_xmit() and dsa_switch_rcv(). It removes the kfree_skb()
calls in those two callers and adds matching kfree_skb() in every
tagger error path that retains skb ownership.

Closes: https://lore.kernel.org/r/20260610153952.1685895-1-kuba@kernel.org/

> diff --git a/net/dsa/tag.c b/net/dsa/tag.c
> index 79ad105902d9..107e93250b94 100644
> --- a/net/dsa/tag.c
> +++ b/net/dsa/tag.c
> @@ -79,15 +79,16 @@ static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
>  		if (likely(skb->dev)) {
>  			dsa_default_offload_fwd_mark(skb);
>  			nskb = skb;
> +		} else {
> +			/* Just drop the skb if we can't find the user */
> +			kfree_skb(skb);
>  		}
>  	} else {
>  		nskb = cpu_dp->rcv(skb, dev);
>  	}
>  
> -	if (!nskb) {
> -		kfree_skb(skb);
> +	if (!nskb)
>  		return 0;
> -	}

[Critical]
While the ->rcv() path in dsa_switch_rcv() is now consistent with the
new "consumer drops on failure" rule, the dsa_software_vlan_untag()
call later in the same function appears to still follow the old rule.
Can that produce a double-free?

The relevant block, unchanged by this patch, is:

    if (unlikely(cpu_dp->ds->untag_bridge_pvid ||
                 cpu_dp->ds->untag_vlan_aware_bridge_pvid)) {
            nskb = dsa_software_vlan_untag(skb);
            if (!nskb) {
                    kfree_skb(skb);
                    return 0;
            }
            skb = nskb;
    }

The only NULL return inside dsa_software_vlan_untag() is the
skb_vlan_untag() path in net/dsa/tag.h:

    if (!skb_vlan_tag_present(skb) && skb->protocol == htons(proto)) {
            skb = skb_vlan_untag(skb);
            if (!skb)
                    return NULL;
    }

skb_vlan_untag() in net/core/skbuff.c already frees on every error
path before returning NULL:

    err_free:
            kfree_skb(skb);
            return NULL;

That is reachable on a malformed VLAN-tagged frame, for example
through the pskb_may_pull(skb, VLAN_HLEN + sizeof(unsigned short))
check, the skb_share_check() failure, or skb_reorder_vlan_header().

So when dsa_software_vlan_untag() returns NULL, the original skb
has already been freed by skb_vlan_untag(), and the kfree_skb(skb)
in dsa_switch_rcv() then operates on freed memory. Is this the
same anti-pattern the commit message describes as "conceptually
wrong: the pattern elsewhere in the networking code is that
consumers drop their skb:s on failure", and should this call site
also be converted (drop the kfree_skb(skb) here, since the helper
already consumes on failure)?

The path is reachable from any driver that sets
ds->untag_bridge_pvid or ds->untag_vlan_aware_bridge_pvid.
-- 
pw-bot: cr

