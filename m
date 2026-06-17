Return-Path: <netdev+bounces-300189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R2lPETuqMmqr3QUAu9opvQ
	(envelope-from <netdev+bounces-300189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:07:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09269A6AC
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:07:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300189-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300189-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BB043079ECA
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0A8421A07;
	Wed, 17 Jun 2026 14:06:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11DB3D47C8;
	Wed, 17 Jun 2026 14:06:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705203; cv=none; b=S3P4vNpho0LVb2XYOab+GH4yAZ4hFBK9My/0Ct6lw8x6vquxRCZHqRTrs/SKJKoY8MlS6RyJKpd2gWB3iNvYqwrf6ppKDNFYZewBJhJXwvwAnN4jZZr3DuBkaDAbLCd4xse/iDOhwRkO4pkbdAbJ8+AcwRTtfiWp0RivrQd4nBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705203; c=relaxed/simple;
	bh=GvUXMhJ6BD98g8iWlJJ3tmsUzN7ymVroCfhVjs97akA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsS2+SxrO8w3NsbXqdU9imE22lReuhSGSzLVtOUuPDmE0lucq8zEkBOqGdp+2WrRki0+vpsVWLQRFHFsj9S3TTqU3HPNs/XRsgEHzkoLRsOzc6hYzp847HdSBhIpoLwC+iGYaJp44HY0Dmmb5bfeYoSiGphVnSuFVQ5/vZQzuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
X-QQ-mid: zesmtpsz2t1781705132t2b420895
X-QQ-Originating-IP: 21Khx59IQJ493P4I8PsMaH5ePQ7lWhJwDioX3o8kxBk=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Jun 2026 22:05:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 122835653084708214
EX-QQ-RecipientCnt: 10
Date: Wed, 17 Jun 2026 22:05:30 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net] net: rnpgbe: fix mailbox endianness handling
Message-ID: <5249B5A1F6CD9ACB+20260617140530.GA278329@nic-Precision-5820-Tower>
References: <20260617083531.251119-1-dong100@mucse.com>
 <bf5366c5-88ae-418c-9c5d-b2249a7f43fc@lunn.ch>
 <0C93ADB24CB93157+20260617114614.GA273003@nic-Precision-5820-Tower>
 <26517b8f-33b7-4de7-8fe8-c7dca5fa7a4b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26517b8f-33b7-4de7-8fe8-c7dca5fa7a4b@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M0wYV6TTeeWiJExMEhGNybSYB66a+j/CEAlWHEuBrY4BnJpRkw3yE6zI
	BmWz7X5GTSOQ/h2HDODo1GbxYdRQV5NIDIkHABvg/xLReNfQVmxrBvft6vjQ3qjqN37q053
	VL+n9jJGFGhp0Ge67veYRUBECvgx+/NIx6bAJ5psYkU6cYQgC/XeVTOw24ib68RnWTgUVVe
	P0gFif/iVv5eroiSjwevGfKfchRijvr2DLQrDRNo3G1DV6+WZappYpYLdpVlwwiHmz1PS5/
	sxKqhWNHx3O8EpAbuM55iGwicOpupAAdZejwEkdCTC82TgISViuDJUw2jqzA6htO7F3/Bl2
	lztdsH1djUO9IaWN5CHnYZj7uG7Gs/nVp+bxdRrA6jnrj3+POPBusaAmncy7XcpQenkoKOH
	nkP4XnPhCcoyZ8eMFU9JRJTt2X/YwiSssALh2kwgWxAQNKEcWj/lNSafHVW782gNyZJ0mif
	8VzLB7RJOtEKPQPfU2P1LgNePt7mh2z41hEaEOu2MkfmU3t47Wy/lk0Nf9zSeIqv8Vn7RS8
	HvRUVhnSayRRLpn7ueVwjbDPWEhac7QcY8cDAZqV0zG8ca0UF1UHX3ORxza7kjQfqKCwywk
	iE9Irh+f4jW8jE+3425uvbfdmO1PKsbIwe0PIRxO0eB5lXfiqUwY2tnkOkmK08TDrRegkc6
	UX7KU1y523QXVh7VjcPzKKR/PcgeQDxmVLjUWBh7AsapwEeLxSyeBDZccn5P5rhdcKQbzV6
	x5SnX/e5Zk6EZNwhhZTBE0f01EEKBSD/1ixzqUxZ5qMvZZrCb0NOX6MH/aNunx9xgQYJzZQ
	EUZTA4RXQ7eldq10yo5gYmuvMd2wWmEghTRwuKD2hiygMHEDX0TUusc9nwCLvlKYi9vp659
	VVPHnJjUISbUrCkj6+yjVk64ThV0AFMmK0V8FzKL25bNQe3FpN3ljSyq6MRGBy1Tt0b0/gR
	wKH/9NiQTLSMDp7Z539fm56gfFqbFfHsEzrBd/xSH1gm0IazVUNDbwtdFTjgjmrVtJEVOKP
	m9+XQkkSV3KGfFGLduj9YZiOGQYDWsP60pK/t0dNY0C+iSG1Fr
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yaojun@mucse.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mucse.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300189-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nic-Precision-5820-Tower:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA09269A6AC

On Wed, Jun 17, 2026 at 02:09:00PM +0200, Andrew Lunn wrote:
> > My understanding is as follows:
> > The firmware structures are defined with__le16 / __le32 for wire format,
> > but the original code cast these struct pointers to u32 * before passing
> > them to the mailbox read/write routines:
> > - Send path: (u32 *)&req -> msg buffer -> writel()
> > - Receive path: readl() -> msg buffer -> (u32 *)&reply
> > Sparse only sees pure u32 = u32 assignments here, so no type mismatch is
> > reported.
> 
> Can the code be changed so that it does not need the cast? Casts are
> bad, as you have just shown. This is something i try to push back on,
> it makes you think about types and avoid issues like this.
> 
> 	Andrew
> 
Thinking... Yes. A few possibilities:

1. Make all fields __le32, then extract via shifts:
   struct mbx_fw_cmd_req {
       __le32 word0;  // [15:0]=flags  [31:16]=opcode
       __le32 word1;  // [15:0]=datalen [31:16]=ret_value
       ...
   };
   But that's painful — le32_to_cpu(req.word0) >> 16 vs req.opcode.

2. Use a union to keep named fields while also exposing __le32[] access:
   union mbx_fw_cmd_req_u {
       struct mbx_fw_cmd_req req;
       __le32 dwords[sizeof(struct mbx_fw_cmd_req) / sizeof(__le32)];
   };
   union mbx_fw_cmd_reply_u {
       struct mbx_fw_cmd_reply reply;
       __le32 dwords[sizeof(struct mbx_fw_cmd_reply) / sizeof(__le32)];
   };

   The transport interface becomes:
   int mucse_write_mbx_pf(struct mucse_hw *hw, const __le32 *msg, u16 size);
   int mucse_read_mbx_pf(struct mucse_hw *hw, __le32 *msg, u16 size);

   Callers would use:
   union mbx_fw_cmd_req_u cmd = {};
   cmd.req.opcode = cpu_to_le16(...);
   cmd.req.flags  = cpu_to_le16(...);
   mucse_write_mbx_pf(hw, cmd.dwords, sizeof(cmd.req));

   If the transport layer forgets le32_to_cpu(), sparse would catch it
   because msg is __le32 * and mbx_data_rd32() returns u32.

   The downside is an extra union wrapper and an extra level in field
   access (cmd.req.opcode vs req.opcode) — a minor inconvenience.

Do you have a preference between these, or another approach?

Thanks for the feedback.

