Return-Path: <netdev+bounces-259385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKb+KydklmmtegIAu9opvQ
	(envelope-from <netdev+bounces-259385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:15:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1695315B57C
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96142301D6A7
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE9686277;
	Thu, 19 Feb 2026 01:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBEs3v/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F2155389
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 01:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771463716; cv=pass; b=gbrB/1ejCmDj+FbsDVqzH+fZxsZONT8cIUrkgQxbIVV6nY6kaiYkzvOLRO3JKRoh/U4vfCU4Wc3jruhHBB58AB7Pr5qhJQBJ/AG+zHxEfiI7W5m452eVfkw490fqYxAqK3kWJSYkdnFYcirXzhuTKVSHypFPa4v+AZsxZUvMtJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771463716; c=relaxed/simple;
	bh=ctj0A34BBcl8YU4X9ndW+0hi3zBze2oEYhGHj+srXyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPU3WReDVbHwBQ6EqujCy39jSQMxCzW9Vy3R+rULv12A8nNTYmSO2Q8RI/pxc5Zy1rsTgC9elLn/uzq9AnOMFPrqvLMzT+W44DDS8/1A6nFkWDkMpOimnBochUqmssXulQG73dd4KK52yYAy2aH3f8LMu7A2XHrCE2RHt8UDvJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBEs3v/1; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2baa098ffc6so411161eec.0
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 17:15:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771463715; cv=none;
        d=google.com; s=arc-20240605;
        b=KXangatq5GOWVpnuflUsjRc/jMwcKFQYp9PlhXDWcpcwg3bSpRcdZ4/TgyFpuJP4oy
         rZEm5wV4LqExRoxcg0pWZaJoE3QJ6ZiSS6H3v1/Q3y73L6soqCP9rtPUprghL5dnukc4
         anE47ddM6DzKsBXtQGOAjbhwhcaWi5BFVwHgkMaJoX+jf+3O6+TFZkH55dwA/+YeqR+e
         Bl+0vXOM8vNVfoELAeXQVLWI3HyQbwhwzIMqA/Ki1/POcLRmHFzjpFRF2pziIp8cOYpw
         9m6O2GS5/lUaMiHuIJ51ovMXvUA+Yu4u+F8AFuW0wV6o/7kV1rnyKhSshYooN3BHKG59
         xsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNU2kGRZs6xFZBhKK37qUUEfTohjI7Dl8i1IHJLa5Kg=;
        fh=n9vBgEvsiK69L+xXbdkyTSNkUQhdWR3bUA25ZKsXQ+8=;
        b=gm6M9a5mc/0DojqXchtpuCd6K8SbKA9miHD377UucVu18lqHpsu5CTjeYIc6KQylRV
         NwQ1LkkqxNse039DYU2UAowpwZSC0rfUbwZj1uCMozf4dR8lLf1CqVJAsXrJeYxBu/dk
         CtfjQB9stYrNTX7JO1Wg/hX70zBWlLRGde0dNBPc7+8vEoFPpxH7ovYnG4VxVqFo8Ptb
         6V17DRSLda5/LgEUjSS8FDNhd+XmBDFHx8ukeqn9T9kU5sVs1mwdWBWxybDE3cyGXCFQ
         csXU+aWpfQZFXAuauYmSBOkyfAhXhz0/3XTm6haZE47RiwJg4MPmrp2UwXS2bFnLqfq/
         QHbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771463715; x=1772068515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNU2kGRZs6xFZBhKK37qUUEfTohjI7Dl8i1IHJLa5Kg=;
        b=qBEs3v/11c6LGzKsD4lCPRP2YdpZZep/8dDAcuLNobR4Nj22EcNzgjlhccNG+rumvt
         EvrM8jXvgxzLAQe0YZdbIW9wgkKMHw8nyMgEYdqLR2Q2IBoHgKngrsg8vZg3tIH2x9RX
         Kv/YmQkRBOlOc0F0xwX5hD8YVDv6QNeHtyu71bOKA/POVHOCD6+rze8InpKV+dUpfs81
         xUdn4kiqqxEGwS8dD96Is368zs9Dax7EP9R3ZtUEqt4noyaESpkSMuk0ETqi4cV6/2I3
         YDSjF5Am/91Ev8HhBjGMndvygxg1A+Hu2Sax7HQMy/CqikqDYXFKCTlt05DWo7f9lzVc
         N2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771463715; x=1772068515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNU2kGRZs6xFZBhKK37qUUEfTohjI7Dl8i1IHJLa5Kg=;
        b=jf6yngvH+xcG5X4OHDPN6e4pE0/uAOG+O9/2xvrAW2kwQSF8fBFzGtlYfey+N45u9R
         K4VyuAUnkHzOFdbzocWy9B2UpVM4hqM/CXChOv7QLV1Wbup1SxAC1Nn3Vvs59ZUmeGOv
         b/7LLyj/6/8gSh3iDh834sBTd4ioaD2Wv/ciVx1PE7mxjsS55IrVcGHcLIhYfuf2IKES
         C5YL6BwnlunP4tUgh97SNJH4EL9Gpe78j50Nlz+KJAXd6xzKbyeFdEAnPrsT+kBR4lkg
         TBxwur/tmnhpBfM8ldw+yJ8gOog6UjCX9KrRiGKMBC1y7mIIj+36pxnZKNo47O4/tddM
         r7vA==
X-Gm-Message-State: AOJu0Yy0FDG+b+TxoTzclP9ocgDGwtXXK+DCpX9IqFP0Nhrdp3SGQQUS
	hGu5GhGcEGI/NKo0VSHkYAoZWrEy0kXuzD/cnkXf06MJo0GBDOskOyhiAnLAlFWgk+jQKeqmJBi
	z5LZGaf9fCh9LbPabtcN7mrO78B56CXHq3jAADGL2
X-Gm-Gg: AZuq6aKTyjQO+sQ1Sj+SF02Lo3LUv/pphubxbpIBMwNyTwBQ78KRWEushY8a+GxGfL0
	KTD0is5MkQDwCAm5aQXGd+iKi5t/4LRMLlJrbVmkr2mFKb2LGPg8ORvJeewSiZ5B6dlvpHeRiYr
	2c1bQXKvbrP8CwoZt19kAc8m1f1TzdeEzp5vot2LPcKleeSKwcm4aDXNr3b6EERGGClOLwrJv3I
	Y95AUIOaCynupxuf9ugi1vOwjhn+pXe89y/Q5Zy/Sy9BbsVRIjEuKPe3H/huee9FZxRj8Dw7x4a
	D/ex5y3tIAt2Ghe0r4CnQZ1fT3UtpZuVc4cwKgSluT5dmWYYKHaGckZdoDqCGqAHU7//2g==
X-Received: by 2002:a05:7300:cb15:b0:2b0:48f7:837d with SMTP id
 5a478bee46e88-2baba03cffcmr5448502eec.11.1771463714076; Wed, 18 Feb 2026
 17:15:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218214550.53342-1-sam@gib.games> <CAAVpQUBjcsEqhzhCqEn9C+UnJenT+FS2ojKu2Z1y+5ppruJqgQ@mail.gmail.com>
 <SJ0PR11MB5661249BD698DF2C4A797439BA6AA@SJ0PR11MB5661.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5661249BD698DF2C4A797439BA6AA@SJ0PR11MB5661.namprd11.prod.outlook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 18 Feb 2026 17:15:02 -0800
X-Gm-Features: AaiRm502Zp926Mh-u_tVPri__q_SJWSoIqePXhw77TuguhP4830AoWU-O9lm18o
Message-ID: <CAAVpQUBg+fwux+etyQhX+O3ynQpKv8r4UBqQ81ppCQafmZHsJA@mail.gmail.com>
Subject: Re: [PATCH] nfc: llcp: check skb tailroom before appending TLV
To: Sam Swicegood <sam@gib.games>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259385-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,davemloft.net:email,gib.games:email]
X-Rspamd-Queue-Id: 1695315B57C
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 2:34=E2=80=AFPM Sam Swicegood <sam@gib.games> wrote=
:
>
> Yes, both current callers compute size and llcp_allocate_pdu() allocates =
accordingly.
>
> My intent here was to make llcp_add_tlv() self-contained and defensive:
> it currently assumes the skb has enough tailroom and will still append
> even if that assumption is violated. The check converts a potential overf=
low
> into a clean failure and removes the in-code todo that explicitly calls o=
ut
> the missing validation.
>
> If you=E2=80=99d prefer not to change behavior (returning NULL), I can im=
stead rework as a
> WARN_ON_ONCE(skb_tailroom(pdu) < tlv_length) and keep the existing flow,
> or adjust the helper to return an error code and have callers handle it e=
xplicitly.

I think defensive programming or WARN_ON_ONCE() for
decade-safe code adds no value here.

I'd rather make it return void as it's simply not used since
de9e5aeb4f40e .

But it's net-next material, and it will open next week.
Please read this guideline for the next submission.
https://docs.kernel.org/process/maintainer-netdev.html

Thanks.


>
> -----Original Message-----
> From: Kuniyuki Iwashima <kuniyu@google.com>
> Sent: Wednesday, February 18, 2026 4:07 PM
> To: Sam Swicegood <samswicegood@gmail.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org; pabeni@=
redhat.com; horms@kernel.org; Sam Swicegood <sam@gib.games>
> Subject: Re: [PATCH] nfc: llcp: check skb tailroom before appending TLV
>
> On Wed, Feb 18, 2026 at 1:46=E2=80=AFPM Sam Swicegood <samswicegood@gmail=
.com> wrote:
> >
> > llcp_add_tlv() appends TLV data to an skb using skb_put_data() without
> > first verifying that sufficient tailroom is available.
>
> This is because all callers (nfc_llcp_send_connect() and
> nfc_llcp_send_cc()) calculate the necessary tailroom and allocate skb wit=
h llcp_allocate_pdu(), no ?
>
>
> >
> > Add a tailroom check to avoid writing past end of the skb when
> > building LLCP PDUs.
> >
> > Signed-off-by: Sam Swicegood <sam@gib.games>
> > ---
> >  net/nfc/llcp_commands.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c index
> > b652323bc2c1..10acc5da954f 100644
> > --- a/net/nfc/llcp_commands.c
> > +++ b/net/nfc/llcp_commands.c
> > @@ -300,9 +300,10 @@ static struct sk_buff *llcp_add_header(struct
> > sk_buff *pdu,  static struct sk_buff *llcp_add_tlv(struct sk_buff *pdu,=
 const u8 *tlv,
> >                                     u8 tlv_length)  {
> > -       /* XXX Add an skb length check */
> > +       if (!pdu || !tlv)
> > +               return NULL;
> >
> > -       if (tlv =3D=3D NULL)
> > +       if (skb_tailroom(pdu) < tlv_length)
> >                 return NULL;
> >
> >         skb_put_data(pdu, tlv, tlv_length);
> > --
> > 2.43.0
> >

