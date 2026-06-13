Return-Path: <netdev+bounces-298829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3QomO62dLGpjTwQAu9opvQ
	(envelope-from <netdev+bounces-298829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:00:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 004D067D1E7
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:00:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=QTsa7Z4i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298829-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298829-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3043030011A1
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD682AD10;
	Sat, 13 Jun 2026 00:00:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D0125AA
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:00:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308841; cv=none; b=dWdnLKMZOR52kw28R4cA5vvRzYa2zd155u63Omo/cR4Ma8tdUm06daAqdnvHOKpNBQus7NSFX2/ZqdWqNEJYw7OLJ6iJKYo57C7u+ur3qgAm0mvw/IJ3RSfq+CG6q/OguG9oKYFvMgaB4RDn+vMy0Ft1L/Np4omMjQrulp3JO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308841; c=relaxed/simple;
	bh=J0WzJpD/x+q+vxJv2njAkDDF3911Tp1Td3ILzRFuhFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHr9kPyG0H3NSE7GDLwB8U+4LN5zeD6BACiv4XeTi9JdZDSCETQj5Zxt+uoW8+uaN7UXFe8y8BUFuYgWI1dwKUeA5UrESFjDucRNImdxh+I6nDfyeS7HLrR6bTJB0LOIoC5QWnfGJrZyd9EvFYvCu8PcykbRxTUzB3MkMYvVtpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=QTsa7Z4i; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84275887a3fso1852020b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781308839; x=1781913639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4w1/sjBs167L+wbRQHAYtjy5PaFRFJl/qC08ynozT8=;
        b=QTsa7Z4iNJ67/wuvxzBkiGd3+K0hWlIRPlr2Y7GlkyxvC7n6BOeYlF/adlDDMKnmKL
         b2uLAnwHyp5EjA2fIaSoDW7c1N0xNflE1plrDcBpz1L5r6TpdkwLEdP3iCi8rVphmtZZ
         h3xIPpX197I1GqcHjR0BUOoEpJ0ljysMbF7pYRrO2K0gIZ/vHb3o/d9bkeLs6esG10T7
         QCHqQvhvBHGz/7sf2v+clSprxEra7XHsLvDguytMZTltpWsZdcdaRX9DsjzbBTTebJvx
         l78YubcVFAt+cGoMLW/NEH2Vg6Rddh7xE/SOmZSulIsBLLOoYPicSKiUEKybYaQJh79v
         xvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781308839; x=1781913639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4w1/sjBs167L+wbRQHAYtjy5PaFRFJl/qC08ynozT8=;
        b=NhYcLhwKJrnfrr2hNoF9ZfWtWgq2q+5oAaaAHs5P6QbVRBWIEesm8JqIUuXz65AJoe
         f31OvZKr6ZkAmB4EJ2QX3wEaErSC/5I25GTwWdlAtEUU0VQsBLlPcUvKI0BuTNjzkU7S
         inD8nj70b6uJfXf8VRjHV3VnAWjml7e5kBaCV+WYrFsH0YehmGOY2QgZTwWF8TvEFwMI
         xm0uzmaJyDvg2XmLmH7ltH+avglXiypgFKu3wwnRfL9e9pn8j01Bjz6YGp3TLE/fPXtf
         /Ew+eahymPpALttjOIsJttFZ3exHB3ujimHLn6ib8C1+zxfqcjWoTDUkBl1kAics5s2w
         VyUw==
X-Gm-Message-State: AOJu0Yz8Hn772s8CKttxeV59T89MKit02RTVHlXT/ozHfU8vaVHMpc7Q
	LGh8PH1C2MQz2iibvNkyhlzWh2fPgYTPX8JA1/LsZZWNo6Rf5VMMCxJOB+TVzdZ5oA==
X-Gm-Gg: Acq92OHlC3biBkWZV1YPOZRAHPdgoimOOw7i+gkLENFcdVrRvSQsdnrsZQQ11aIOepA
	pL0zeLfHuKDuvemndpV6I5Nq7d7F+pt1cBMNRpSxeTqR78Rih8jjqujMYi5b4R7rnW4fmPVDfhl
	ElSm/2+s0ZYunk8eUBX98q9gRiziWNW/2CXOLK+hpyzeR+ZiPUyab7CJ9tjBq9yBS6Vi3Q12Ea/
	eHqYPyFpGkar8DljqtQLfyU9jfxJ5PWNrd7UcW23aQt1BY2NUV3MAfhun8XM6oA4gxs4zK+vocw
	jWUwqkV14E65x3FvU3t1df7CTXdowgylRqRAb4o5yLDDdR4CtJ99ecP4Bmd+p+TOSr7tbE4rQSY
	+pXgp+JqaDvJMdtOeJK2fElKkDECTQodFzDB08LeKdCh4/X24E4u3aj35qQQNlEEjY9N3Tmdt1s
	xie7Tmug==
X-Received: by 2002:a05:6a00:3a08:b0:837:735b:826f with SMTP id d2e1a72fcca58-843497ca6d9mr4673044b3a.32.1781308838671;
        Fri, 12 Jun 2026 17:00:38 -0700 (PDT)
Received: from p1 ([2607:fb90:ec99:429b:a889:f485:dd02:b10c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b0226acsm3392301b3a.48.2026.06.12.17.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 17:00:38 -0700 (PDT)
Date: Fri, 12 Jun 2026 17:00:35 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Weiming Shi <bestswngs@gmail.com>, 
	Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH net v2 2/2] geneve: validate inner network offset in
 geneve_gro_complete()
Message-ID: <2dgmazkbys3g3wjkxfh62tgg5ru2pchhegoavf33zzh4d7lhpb@pdqyz2dcypbj>
References: <20260609041334.2506153-1-xmei5@asu.edu>
 <20260609041334.2506153-2-xmei5@asu.edu>
 <fcc21647-d7ac-4b9b-ac61-42fec517cb99@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcc21647-d7ac-4b9b-ac61-42fec517cb99@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,lunn.ch,davemloft.net,gmail.com,openai.com];
	TAGGED_FROM(0.00)[bounces-298829-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:bestswngs@gmail.com,m:kylebot@openai.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:dkim,asu.edu:email,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 004D067D1E7

On Thu, Jun 11, 2026 at 12:47:52PM +0200, Paolo Abeni wrote:
> On 6/9/26 6:13 AM, Xiang Mei wrote:
> > Even with both paths gated on gs->gro_hint, geneve_gro_complete()
> > re-derives the inner dispatch type and length from the packet and the
> > current gs->gro_hint, independently of geneve_gro_receive(). The two can
> > disagree if gs->gro_hint flips under a concurrent geneve_quiesce()/
> > geneve_unquiesce() (sk_user_data is NULL across a synchronize_net()), or if
> > the re-read option bytes differ from the ones receive parsed.
> > 
> > geneve_gro_receive() already records the inner network header position in
> > NAPI_GRO_CB()->inner_network_offset. Have geneve_gro_complete() check the
> > offset it is about to dispatch at against that value, adding ETH_HLEN in
> > the ETH_P_TEB case where eth_gro_complete() steps over the inner MAC
> > header, and bail out on mismatch instead of trusting the re-derivation.
> > 
> > Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> > Assisted-by: Claude:claude-opus-4-8
> > Tested-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: Add patch for race condition found by Sashiko
> > 
> >  drivers/net/geneve.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> > index d0dc5d6c46df..028740e97740 100644
> > --- a/drivers/net/geneve.c
> > +++ b/drivers/net/geneve.c
> > @@ -956,6 +956,19 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
> >  	type = gh->proto_type;
> >  	geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
> >  
> > +	/* Bail out if our inner network offset disagrees with gro_receive().
> > +	 * ETH_P_TEB adds ETH_HLEN for the inner MAC header.
> > +	 */
> > +	if (skb->encapsulation) {
> 
> I think the disagreement could happen even in the opposite direction,
> i.e. gro_receives does not see hints available, but gro_complete does.
> 
> > +		unsigned int inner_nh = nhoff + gh_len;
> > +
> > +		if (type == htons(ETH_P_TEB))
> > +			inner_nh += ETH_HLEN;
> 
> This does not work in when the innermost headers carry a vlan tag.

Yes, you're right. the check is wrong.


inner_network_offset is the inner L3 offset recorded by gro_receive. For a
tagged inner frame eth_gro_receive hands off to vlan_gro_receive, which
pulls the VLAN tag before the inner ip*_gro_receive records it, so it ends
up at nhoff + gh_len + ETH_HLEN + n*VLAN_HLEN. We only add ETH_HLEN, so
'!=' drops a valid frame.

Do you think a lower bound works?

For example:

	if (skb->encapsulation) {
		unsigned int inner_nh = nhoff + gh_len;

		if (type == htons(ETH_P_TEB))
			inner_nh += ETH_HLEN;

		if (unlikely(inner_nh > NAPI_GRO_CB(skb)->inner_network_offset))
			return -EINVAL;
	}

A VLAN tag only pushes inner_network_offset later, so a valid packet has
inner_nh <= inner_network_offset and passes. The opposite direction you
mentioned (receive does not see the hint, complete does) inflates gh_len
in complete, so inner_nh goes past inner_network_offset and is rejected.

The only case this does not reject is the reverse (receive uses the hint,
complete does not), where inner_nh lands before inner_network_offset.
That is in bounds and only reachable across a concurrent
geneve_changelink() quiesce/unquiesce, so not attacker reachable. If you
want that too, we need to record the offset gro_receive used in
napi_gro_cb and compare by '=='.

Xiang

> 
> /P
> 

