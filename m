Return-Path: <netdev+bounces-306958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LFs4NK26U2pseQMAu9opvQ
	(envelope-from <netdev+bounces-306958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 18:02:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E2474548A
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 18:02:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=UyzSvgh1;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306958-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306958-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13EDC300E5C0
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096E34388E;
	Sun, 12 Jul 2026 16:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9D342539
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 16:02:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783872163; cv=pass; b=JYE0OSCAtl07w2Hmj/owEY41qLnJWDdMo5DPkpX84LnWjJVqH5LMA2ScnXxFSVmC4irKxil3cXJS4sKFYp+UxJiK5FP1ZkSrmQWvkFA2y9napn4ehgRaMP4HrBJQS+Is14D56wcMrNZwMfslzKZiIO8a4n4V3zUQWovj5pocdSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783872163; c=relaxed/simple;
	bh=lEN1RDO1utLqCuN68G05+ujxtG3nu9JpSH8sV9ic7Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atAVzCdEiR3MEsMJdGT4GZJGBfTwPu6TOnR+ycK2xrNn3wS0IOKehBA3a9anJD4fy0KCFzT4wOAhs/huA9kaQf+6+GOAFG/veaVVkJ9AahTMKRU97qxGnRIRD2Ghfb9/x+xMS23jGHEB5Q0D0rQFy+5QIEaUVztRRUI7FDCTwxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=UyzSvgh1; arc=pass smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc97653887so26523025ad.1
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 09:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783872158; cv=none;
        d=google.com; s=arc-20260327;
        b=Di1ot9tWFhdSPZ7k6ZRoBEAepJ7A5v+s0+vQPJ50DTM10082UkTg/mSVib9OEWhkWU
         6/dI0k7vuf0o7giLppb6hMeIfHsj7K8mXTpGWTv6Bj9zh+qeQyVKOKsGwJFxLyqxXeq3
         /rP/VvUv5H7cZ6tEUYylls9gaLSAmHDV3vdKheBhvji8r2sFc/LUQX8RS4WiVdqokR+N
         V+XGDANbaIHBXoTxOClTsneiG8XagYXKPoTLhS3gs21RcsMv0l/jqLFHuMN5oz1QDVEw
         I8aL8eK3cO8VnxfxHD4eiOCPh+s3U55iwXZ2csoU0eJfvv14KzZKbNQe3aboLenNW2VO
         gOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y8gOd+Q3z89xRep8w0XzdPaSt7VIYP9aT1DEEYw2ULY=;
        fh=ESLoxzSM5r87TsjnA3oWJ23t52anXaMA/8JveU5zmYY=;
        b=ICoHHlUq1J+OMG1qMqdOPVcDlvLT0CL8uVAy8cnZtV3r65SOrw5JmyjLgpD3XYwkPI
         7Lqrzk1VwdKy9Hx39qZPGk/kj0V24AgwaqsZRFpEd18WbgFFqRGmdAN+rCcY25RPQQyu
         eiBwFyPwW22twVKc6O90hzlAgRGbRpw4VF4WjVd0zgdxUMuC+0ff0hUHjA4lXqTKA80C
         vqM6uigc+uCGuGMW2H0r9PYYQS182zceHHgUNZvwzWF2BX11aQdavuqMXqqMaQO1/1gT
         ZeaBWZguq6VpVCegNeSvJkqctEr9stgCuPTLeuSTt3xoKh4LL6ApCWap0PKslv4R04oz
         MDvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783872158; x=1784476958; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8gOd+Q3z89xRep8w0XzdPaSt7VIYP9aT1DEEYw2ULY=;
        b=UyzSvgh1DSo25sz9JUH7LAEQYx9BMF+mB73o0GzGMxtQ378cZRnGojCu+dD/ic7RZn
         6JceGpLBw/0SgcsKVCR52kBm4F2Du2aMyjgISzHNdB812vaSwkx424f+2H+xfE+P4T6r
         H965lm/wzQ3xU25gEcc+fevOrV+JU8g1qMjYVrF7wCzMqmljJGxeWMwUw4hahRRtNawr
         zOt9Gd4SYOmRZdenLeLc7078SdrBqOXqedNdY/MXPKE+WK409Nc5pa+aEJju/ctXTUbB
         eQgTYSY0c/dVfA/ortM1UDNfYh0S3opSb2paDzLnuTy3S01Gb3UtHf6RfTf0Yde5pumL
         m6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783872158; x=1784476958;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y8gOd+Q3z89xRep8w0XzdPaSt7VIYP9aT1DEEYw2ULY=;
        b=NZftsus6WqIt1CWfOePNVCnRvoPWrhuXQEeT7U1//3mLSCG/oj08ESoFg4kHXNApcH
         0BFAcTFRiqTHOumzrS8JqI8Sig136x27YOWlIWrYXJpgHWeOVf+oz5zAKJhuhwlSVQ/V
         lyUEQxP6ttRcHLD56UYOlGTRZlq5DQ9bPunBf304D7af4tiVlmtyDir0dmzmPQTuvWTc
         WhCO41UKznr6P2OogvPXKrx1aXEGMQYscHM4QfLKSkllQ7W8rg4w+TRRPGVJSq/6bO06
         xxW1znGcPB2dloY0xBsFu0cYGFFgdNaOi9GiqqVAEef7uAuD/9G1BDF1xlCAtzf1+gP1
         4XSg==
X-Forwarded-Encrypted: i=1; AHgh+Ro3YomQKo6MA5bOWWINJ3E84bUxCKAJz4IJie4fDe7356WLOfXHYa6uMun+p0EUYB28VNQ6Gh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1WJmTqpieEfhHmLtnvVqPI0V9JCQmN7GkOc39EQl3IBXO9cnA
	hrPROn3voIj8cQZuK3x8AAzZQeqk4i8dweaXYXJjzG9GfLApDg7QIbPN8i5g6LtdJM16+ZXTOuP
	vk47nuVBf1hxMz+3LH9bgvfEWpfs7y0+iKBYF1FVvy8w=
X-Gm-Gg: AfdE7ck9j6gAPCNbC3ihhBL4PZGZYvdjFV18iXJAfKkvrc12D32uXcqyThIuKL9eLM5
	pmP2BtiwgEycOqhXL9kpoRwMX87Mr+APvRLg2VlsrcWU5K1E5xGxONAqN7aG8RvKBbDabc1hxQk
	m5EdRyGkc8HVxJmWU7VKmTvfb7xS8DctiTTis8mrTH+mbEajqezGYI52RdjGSYTD1HckLQlXbXE
	kYRb3eQNo6FlVUPJzqWDqihNdvUTe0BfT+7D5ipIRwNcad2COpi3e0FYK0QMGmQlYULKh6jz2QZ
	UfWsrHhyki1uORqRRmHrZg9O/USQbYUYcyDgpiAtzyLoQfKTBDvNYiGMd7sW
X-Received: by 2002:a17:903:2444:b0:2ca:c4a5:84bb with SMTP id
 d9443c01a7336-2ce9f27e6f1mr63459385ad.38.1783872157981; Sun, 12 Jul 2026
 09:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711072702.70231-1-doruk@0sec.ai> <be1731eb-e6ec-4015-92e4-c09fd88019e6@linux.dev>
In-Reply-To: <be1731eb-e6ec-4015-92e4-c09fd88019e6@linux.dev>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Sun, 12 Jul 2026 18:02:26 +0200
X-Gm-Features: AVVi8Cfuvaa8c4Hm1hNjjBfiFUfKj_52zwFcdM42IhGHFkrP4Lc2eV58kzfpMGc
Message-ID: <CAPdMp1p=72WXe-8w5Y9viBuB6YvZWZomNc9xQzXEg-qe1WVN0A@mail.gmail.com>
Subject: Re: [PATCH net] nfc: llcp: reject PDUs shorter than the LLCP header
To: vadim.fedorenko@linux.dev
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306958-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,0sec.ai:from_mime,0sec.ai:email,0sec.ai:url,0sec.ai:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62E2474548A

Hi Vadim

this was reproduced from userspace on unmodified
linux-next (bee763d5f341) without RF hardware.

It's the peer-RX path, not a local command skb:

virtual_ncidev_write (peer NCI DATA) -> nci_rx_data_packet
-> nfc_tm_data_received -> nfc_llcp_data_received
-> rx_work -> nfc_llcp_rx_skb -> nfc_llcp_recv_connect

Bring the LLCP link up via a normal NFC-DEP activation, then send
one NCI DATA packet with a 1-byte CONNECT PDU. skb->len - 2 wraps
to 0xffffffff and the TLV walk runs off the end:

BUG: KFENCE: out-of-bounds read in nfc_llcp_recv_connect+0x9f6/0xf80
nfc_llcp_recv_connect+0x9f6 -> nfc_llcp_rx_work -> process_one_work
read 4219B past a 704B skbuff_small_head from virtual_ncidev_write
R14: 00000000ffffffff (wrapped tlv_array_len)

With the guard: rx_skb runs for all 600 short PDUs, recv_connect
reached 0 times, 0 reports.

The bound stays "<", not "<=" -- a header-only SYMM/DISC/DM is
exactly 2 bytes and must still dispatch; AGF uses "<=" only
because an AGF frame must also carry a sub-PDU. I'll drop the
"same guard as AGF" line from the commit message.

Instantiating /dev/virtual_nci needs privilege, but that's just
the syzbot transport; the 1-byte CONNECT is what a remote NFC-DEP
peer emits, and the DEP layer imposes no minimum LLCP length.
Impact is a proximity OOB read (DoS).

I can send the full reproducer if you'd like.

best
Doruk

On Sun, Jul 12, 2026 02:01 PM, Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 11/07/2026 08:27, Doruk Tan Ozturk wrote:
> > nfc_llcp_rx_skb() reads the two-byte LLCP header (DSAP/SSAP/PTYPE) and
> > dispatches by PDU type; several handlers then derive a TLV-array length as
> > skb->len - LLCP_HEADER_SIZE. Neither nfc_llcp_rx_skb() nor its callers
> > guarantee the frame is at least LLCP_HEADER_SIZE bytes, and a sub-header
>
> that's not correct. there are 2 ways to get to nfc_llcp_rx_skb() - via
> nfc_llcp_recv_agf() or through commands/locally generated skbs. The
> first one checks against LLCP_HEADER_SIZE, while latter one creates skb
> payload with correct LLCP header size. Do you have a reproducer to
> trigger the issue?
>
>
> > PDU does reach it: digital_in_recv_dep_res() and digital_tg_recv_dep_req()
> > strip the DEP header with skb_pull() after only checking the DEP header
> > size, so a DEP I-PDU carrying a 0- or 1-byte LLCP payload is handed up as
> > a sub-2-byte skb.
> >
> > For a CONNECT or CC PDU, nfc_llcp_recv_connect() and nfc_llcp_recv_cc()
> > then pass skb->len - LLCP_HEADER_SIZE to nfc_llcp_parse_connection_tlv().
> > For skb->len < 2 that subtraction underflows: truncated into the u16
> > tlv_array_len parameter it becomes ~0xFFFE, and for a CONNECT to the SDP
> > SAP, nfc_llcp_connect_sn() uses a size_t and underflows to SIZE_MAX. The
> > TLV parsers bound their walk relative to that length, so they read far
> > past the end of the skb.
> >
> > The aggregated-frame path (nfc_llcp_recv_agf()) already drops sub-PDUs
> > shorter than the header. Apply the same guard once, in the dispatcher, so
>
> that not exactly correct, it drops skbs which are shorter or equal to
> the header, the check added in this patch is not correct then.
>
> > every PDU type is covered.
> >
> > Found by 0sec (https://0sec.ai) using automated source analysis; the
> > missing guard is evident from source. Compile-tested.
> >
> > Fixes: d646960f7986 ("NFC: Initial LLCP support")
> > Cc: stable@vger.kernel.org
> > Assisted-by: 0sec:claude-opus-4-8
> > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > ---
> >   net/nfc/llcp_core.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> > index aed5fe1afef0..e3b3077e0e83 100644
> > --- a/net/nfc/llcp_core.c
> > +++ b/net/nfc/llcp_core.c
> > @@ -1481,6 +1481,9 @@ static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb)
> >   {
> >       u8 dsap, ssap, ptype;
> >
> > +     if (skb->len < LLCP_HEADER_SIZE)
> > +             return;
> > +
> >       ptype = nfc_llcp_ptype(skb);
> >       dsap = nfc_llcp_dsap(skb);
> >       ssap = nfc_llcp_ssap(skb);
>

