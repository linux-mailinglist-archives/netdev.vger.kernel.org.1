Return-Path: <netdev+bounces-297198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9NLAMQxTKGq9CAMAu9opvQ
	(envelope-from <netdev+bounces-297198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:53:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE1663162
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:53:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b=Ma2gjjBX;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="i y/lRKc";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297198-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297198-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B2703027C81
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377074C77A4;
	Tue,  9 Jun 2026 17:42:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407334CA279
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:41:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026921; cv=none; b=qIPGFp504IVIb9rfZV7r5aBL5pZcoS56NEYatIu24Dw6s7Tp5sR2Tv61FSXjdu8rHhv09Is1No2uh0SvTGJ7wqtay9J49OEl1MDTCp4evgnRubwF8MAFsoMjWlPnJ0e0v/RekY92OOHYDcZqUQU+DGb734R3JFLHcUFtc6Y6uEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026921; c=relaxed/simple;
	bh=e4Q1isazpz99HOU3E+1/24R3he1NKFv9e3nObgeFtuo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GNGLv3aq7ih+E8UHMhirVIXSbteXgj20UD//bYFEIdd5A4XLT0mGChplKzUGtm0zGq0U+tTAHF8WyUoE2GClXPvz4HR56cJbP27N26cV/A1QvYwOuzOz07hmViiimvyVtMQBSeZ0/0YH4O0q8OZ7HQm2r/HZbcZk+KYuJ1Q4Gwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Ma2gjjBX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iy/lRKc4; arc=none smtp.client-ip=202.12.124.149
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D41FB1D0010E;
	Tue,  9 Jun 2026 13:41:57 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-10.internal (MEProxy); Tue, 09 Jun 2026 13:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781026917;
	 x=1781113317; bh=Ccwb45dhYsfmemFEqxMkVcZvHm4fm6w18SMr8fzGWfA=; b=
	Ma2gjjBXEquT6+WCaJvnoA1Clj7PjfA4Jzh4Y1hXoxNAbvLFGYrhcrA/ANmoofgC
	wQhPFMKOk79V4Qu4bDGh6X+Or2RnjsB4lmd0suciLocjW9lPZieyNEWZgMknKWXN
	cidxNATclxcwWSkD7AnW7EI4ZixYVokEu9ThLLn/KLYQwzSK1Y4+b8pFTeBtzg4o
	2SKC3T93P6BK4f7hKnN262GTORj3CEWrIq5Mnqs3e5dkQ9zeJrrmEI3NV5l356uo
	AHczS3CX9SaY+WXJemwV2y6zjFTC2MbIa5ghoEK+BvqrPZiuJaruS/DINc94PE7a
	Ucpf2d3hlFb7LpyOvRhRig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781026917; x=
	1781113317; bh=Ccwb45dhYsfmemFEqxMkVcZvHm4fm6w18SMr8fzGWfA=; b=i
	y/lRKc4KLhxcz10AuqmGESzSJL+KcEl7+laSGUY5Y/0JYYifL+WTu9fxWitA9uEi
	2iE/dSdSRdfN4QYn6JTaD4IHtmdLXFNNAu1eUMvm7ipYhmiIeNcpYYOh26eZeXRl
	/LFMJcuPyFg8+i0cgBzQTWievTszU64FNkR/oIEFT5V14rAMaWHAELKrCKuED3qq
	n/1eYYb27jBYs81dVtLQCUYvBYflYiZ8bCErr5DPAW5SswWWj/AkDERSqeYgy+UX
	yqxBgbK1H2p+8tdYq6es/+SZ8HO1VpwXhjj+SDHmfIuX/497IMg1JdL3SRP9WQLH
	lUVvwHSfIbpPNQGdNO9Sw==
X-ME-Sender: <xms:ZFAoag5CHfFYKL10y53vJTCw9TCaRSh-k1TIp0D4Irc421jM1jZcJQ>
    <xme:ZFAoasuHRNem1ue41Xa_nfMfG07dRaU1PpRmqXsRXsePyuuqg6phhtOmC3pUnuXVp
    GckGyQa6QQIM0RptO-IxiRu3v-VF7EB1lX1Sg2WmJotCkeoITPQJg>
X-ME-Proxy-Cause: dmFkZTG3xlVzCiddoXjElwKNOSQ34ODQYmu8dryMLo3MPkBdKZ98mNPCGXq9xRsKMkiub4
    DwUCYf7fHSjQ88WRDO2PxK+aISbiq0dOqDKwNssbjp3UcWdXFkH+7ZPG7ocg74FhPky/1x
    K5CoPSaCUq5Cd51YrYzwURE3RBpHXMUwR7unYc0ANWzUKwYpZEXd1lcTGGk5SgFhtV9Oh1
    Y5btwIQXVpN+8esNMVx0eYqgWW/4JqCU8gZ0Gp+txEu/Cre5I8whBxgxrHRbXWTmGcl746
    T19a6gS02RLzdOrLjIcgRuH77N+UuVdUcp5atx/bsDKFZ3JXQ4odQ7/eTXQdPYoICCccaa
    FtghuJxsvaucBYAc7b1C9ep3jt4mqEfTrBleH/fL6H2HwKn8mhLwTsMRNmzdAM7RnJnfa2
    Cs6laEm6RKQRORv4VkdjsxEJVowkDs0Cr/w/kjkt1Trlj46xucjjIlmjnQ4UlzZTb//5y/
    iNsXAcH5V2UnDGwDFAh6J8dOuJmhFRepBz79lPbV3jiS/5JNaOfseUzrQgelwRoqYXWS0L
    RAJeagxUuuAFbSDwvetR7zw/IgY5yuVc0R1hQuW5TiMj+zDZjRnfBNENOU6C6qQhA1oamk
    tL1g0Lv8h4pRm9hE7vA2F9rRON4BxLf7NygrlWxNR/6YQKVrkPA97aUAD7GQ
X-ME-Proxy: <xmx:ZFAoavehGqZGT_pzzuUsnsLeZsynf2i6JuXBQhp4o2ppjUiKKUqhSQ>
    <xmx:ZFAoaukr9flH_0f8Ezayx8XkR3acte6u3Kb07QxLSAjAlKmPMnO5Lw>
    <xmx:ZFAoahBGoguXSwqTxYPR30szMenGqmYcInd_h-bEATrPW_3g62l8CA>
    <xmx:ZFAoagezAnJd5w0-vgXN5fcX4lgfefSSRlP9sq0A1m6YUCHbfWTrew>
    <xmx:ZVAoapPyz0f7uLIk9pJBjWh_YUMFOerDEaj4OUjufxqNhQvRadXFGsQr>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D28D318E006C; Tue,  9 Jun 2026 13:41:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 09 Jun 2026 19:41:35 +0200
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Paolo Abeni" <pabeni@redhat.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Xin Long" <lucien.xin@gmail.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Willem de Bruijn" <willemb@google.com>, "David Ahern" <dsahern@kernel.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>
Cc: "Shuah Khan" <shuah@kernel.org>,
 "Stanislav Fomichev" <stfomichev@gmail.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "Simon Horman" <horms@kernel.org>,
 "Florian Westphal" <fw@strlen.de>, netdev@vger.kernel.org,
 "Alice Mikityanska" <alice@isovalent.com>
Message-Id: <6bdf5092-d877-4c09-b3a2-07a92b57fd54@app.fastmail.com>
In-Reply-To: <ea5ed9f7-daf5-4996-8c0d-84c2bb946be5@redhat.com>
References: <20260602093931.516281-1-alice.kernel@fastmail.im>
 <20260602093931.516281-6-alice.kernel@fastmail.im>
 <ea5ed9f7-daf5-4996-8c0d-84c2bb946be5@redhat.com>
Subject: Re: [PATCH net-next v6 05/11] udp: Support gro_ipv4_max_size > 65536
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FREEMAIL_TO(0.00)[redhat.com,iogearbox.net,davemloft.net,google.com,kernel.org,gmail.com,blackwall.org];
	TAGGED_FROM(0.00)[bounces-297198-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,app.fastmail.com:mid,messagingengine.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEDE1663162

On Tue, Jun 9, 2026, at 10:32, Paolo Abeni wrote:
> Hi,
>
> On 6/2/26 11:39 AM, Alice Mikityanska wrote:
>> @@ -2605,6 +2605,9 @@ int udp_rcv(struct sk_buff *skb)
>>  	if (ulen > skb->len)
>>  		goto short_packet;
>> =20
>> +	if (!ulen)
>> +		ulen =3D skb->len;
>
> Sashiko noted the above is a bit fragile, as malformed udp skb will
> unconditionally use the skb len.

Malformed packets are addressed in patch 7 =E2=80=94 it closes the gap, =
so that
uh->len =3D 0 can't come from the wire.

> What about introducing/using an additional helper alike:
>
> int udp_get_len(const struct sk_buff *skb, const struct udphdr *uh)
> {
> 	if (uh->len)
> 		return htons(uh->len);
> 	if (skb_is_gso(skb))
> 		return skb->len;
> 	return 0;
> }
>
> and use it here and in the next patch?

Since UDP-Lite was removed along with the special case in udp_rcv, the
helper for udp_get_len makes sense now, yes. The only two places where
it's going to be used, though, are udp_rcv and udpv6_rcv. AFAIR, only
these two need to read and decode len=3D0.

I'm not sure about the skb_is_gso check, though. Given that malformed
packets are addressed in patch 7, do we need this check? udpv6_rcv
already does the following without checking for GSO:

	/* Check for jumbo payload */
	if (ulen =3D=3D 0)
		ulen =3D skb->len;

I don't think Linux supports jumbo UDP with HBH coming from the wire
natively, does it? If it doesn't, and the above is only for BIG TCP, it
should be safe to check skb_is_gso in udpv6_rcv too, but again, is it
actually necessary after patch 7?

Thanks!

> /P

