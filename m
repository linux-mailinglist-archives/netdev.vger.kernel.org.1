Return-Path: <netdev+bounces-287301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBn+HY2UA2q37gEAu9opvQ
	(envelope-from <netdev+bounces-287301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:58:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA030529BE9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C96E30EB0BA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F8C3C345A;
	Tue, 12 May 2026 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCzbgDxb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668140855
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619239; cv=pass; b=i4q9dY25MZYhTxmhfkvX0mtRPMGFbWqeBKS7sxZfu7avxHBgbMxsVjvWziIRohnrPWBOCvzFKF2PRenTOCUFYBVYMqI6GTLXy+UqoGKox9QtXAGkfhPw7AkzSS4pDSChQazjhN1P86heDAcI7T0yVeFyLHQC5UI9loc2tceZmEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619239; c=relaxed/simple;
	bh=uVDdxovl8BEZRGiUt5lo0AdiXLLC3ZtT7UawYlMre8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QInDITq6CiGxo7nkhq5qkKSEFzt1JpkDnwlcuuAo4vmSl9Qo/I4oit9exMwQOAQsm9/GfA2CBGNWQaDD+4IR2YQjumgT03WFFwb7GRTH1mx/BTz0JrdGEd5+Bcj86fejjJFAjIZyRMkjWoKhn5ihePgpqCRzJJ4p4rGrxo/3/UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCzbgDxb; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so9608460a12.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778619236; cv=none;
        d=google.com; s=arc-20240605;
        b=CcBjl5XI1GJwMV2+25x+gT5/97zazs3Do+SSnfrLlSo2ME7rDiQHOSDXxe6tLU5jSA
         A2YQcUVBKeZHg/I6xz0cRJ3xWkRVkVD3jTeU0+tojOvNYFvlusH2zhJzfa7CxScUL83N
         ujfOMh0auLoeW4XBexUqJgIOYOuAbzPkAlSVZTSZ/nC2vtPgetCCJSXa0VPDcOTwgh5E
         YjxOW13B/KfukJBZfs4fcMNTn0JP+uLUkdFu+UHfyns0+96BGIwk2Th2Bi5WLIIWTe6x
         SjJKEZjSz9crAhhd4Zi+n/bBrsR78sLehmm/7QBUOiDBsW60GGXSvActX4igl6lXmGi5
         IDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RbcJK6vCoZqA+nNfHhXD+KaqnS5ArNZN7XG3rTFznHs=;
        fh=CtXAUHG5hXeQXUYJSxxeRoaVJVFL1X1w/SfKr1Ij600=;
        b=fOUwudgGUkJTwHpu1HEwCOnL/HjUWJp/udpWzQy1LmOdXx2QB5LQqisfbHTcQNehXB
         ATY0rshn0s1fLba7A4EgBvR5PeZsuomLhvZDH1yazvVGXUM4lYz0X+eUJ7t0QRvH1fHy
         gmqFxv+sIxauTtwgkL8Hj1zcUhTGpFhXrKz8tMHy+ZaS98xY3ZgMHT1SFbw/uTUr7WXV
         javCthYwvmFMLDKBXsdSLMU45XoX0O4hCLturbv2Ad6ZboR9IWNR0JRuvm+bZVBA7CJY
         +aiYX4fr4tOQ/NtgcW3Z4d7F/yn6Po9WrQxJJJZm7A1qP5aCKCpT/JrYGGih6MC11R2Y
         hKaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778619236; x=1779224036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RbcJK6vCoZqA+nNfHhXD+KaqnS5ArNZN7XG3rTFznHs=;
        b=gCzbgDxbXrJfvWBt0tqTY7OQn6x3+5Pz3Qi94lpVdIPjv9Yl7KSq53CGzbS9gZ2C+l
         xNR8UmOhkzNA06YiWb26cyr4L1ZRAO3WCD4yDOJvOw7x6A5HKPBFFLFsVd51EQCRMgOD
         n5DqHAtolhnmXkjsQcOqSV6nyl/Qn+h0cVQxPLswOArnKXVNmTYnkm8KaKVQ6/FW80dj
         TjU5Rvd38NlhGvxSTKNZZ6yBne79hfTVHFbgm+0mKtXJ21S2J5FMiYfhOOLlGTCLwW+u
         MhvKh34G48Ysphv1yQrGiV3pyusRqv87zKN5pDbqdTza9w8a13DP7sFij+u9JU5CIphg
         Vr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619236; x=1779224036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbcJK6vCoZqA+nNfHhXD+KaqnS5ArNZN7XG3rTFznHs=;
        b=GaqNy7fIEtJRUQ4bNBe3LfJ63AgJSCvwFwDC6VfWZLuZ5JEtBpbB2V1K6x+IxX3t6s
         nKZUuLlI9/kvL6uBlp5zH2a7bxyRhEtteot1tPXLNODQM8QH7zfEQp2m7xLF42iCmxBX
         WG46bdxUUGNb2r42eg4RYIKdBsS/JfhdQO1nfotfkHJKY1WvSGFmxYgVFGwFFNqfLpsO
         S0GjTr2Zq1SXTHAx51o5aDgxdmbaYNqxotMdShnSR5FXHxryMnTcbDQdwapVYI43sQYo
         GxbE9e/bRNTyGAiXTnu/PCqmhZa1VQt1ZXOqidlW7uwidKCsxA21mrhtjz4nrpLuXMWb
         y4cg==
X-Forwarded-Encrypted: i=1; AFNElJ8+78kr6wJT17ADLllvNc9QTi/x5nGIBECPAckQjATzel7LTOVk78mj/AKbaT9X8ScARdsZTp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/L/2maYZ7E8eVlQgri5t53QtEWLm7ofxxElgvE0NCqSfEuUaD
	b2fRtyjLf4aH8J588Fca9CxcX4nZEbAPzjdbUUmkZ+dr3pDUaek6CwSDVvad2nysHoAKVpxZekR
	QGsGUDrB+R2LXiplrw1n44a/gSXUKxZn0mB3H
X-Gm-Gg: Acq92OFXw9S9m4VQYkMaOWFLnURVeNxzkK1RoeJt5uZJzdeInGAha2wCKF5sS6UQrxv
	3zqkSr7Auesd3e8maM7fYs12O8Y8tzoK2eTGrj1yyEVHmZFD7ygKxcsMmkVlrsw+wmWmpqYQgfS
	L0qh/YPAwc9F916YHtgHUBeCt4zAZgMcPDxzC1oPw8WpMERHnY1XzWbHN4DrkXLd0rr0HOcUU+d
	c9t+x6RH6AMYTzRukR1oIoIugd08D6o2eWUeXvozmwzM9l6WCxZvLLn9QmyCSIw0ZRfmfrrxKvo
	8Qh6SDhU
X-Received: by 2002:a17:906:5191:20b0:bad:f5dd:6740 with SMTP id
 a640c23a62f3a-bd3bf773c89mr21012966b.3.1778619236128; Tue, 12 May 2026
 13:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506-realtek_forward-v3-7-1d87c5f85a3b@gmail.com>
 <20260510173516.3920093-1-kuba@kernel.org> <0cbce7f4-e7e5-4a03-bde8-4a62556c3b12@yahoo.com>
In-Reply-To: <0cbce7f4-e7e5-4a03-bde8-4a62556c3b12@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 12 May 2026 17:53:42 -0300
X-Gm-Features: AVHnY4IqkvaoisxcFLOoBpgP3wFTkF4yL6KKJ7O6tZLxky8WX6LyNVP8dRPXkQQ
Message-ID: <CAJq09z6NU4asJiEdMo9gJHkOjiUKcGAMjRb2Dmc3oM1CY8XVRQ@mail.gmail.com>
Subject: Re: [net-next PATCH v3 7/8] net: dsa: realtek: rtl8365mb: add FDB support
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, linusw@kernel.org, 
	alsi@bang-olufsen.dk, yury.norov@gmail.com, linux@rasmusvillemoes.dk, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EA030529BE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287301-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

> On 5/10/2026 7:35 PM, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > net: dsa: realtek: rtl8365mb: add FDB support
> >
> > Implement support for FDB and MDB management for the RTL8365MB series
> > switches. Introduce a mutex lock (l2_lock) to protect concurrent L2 table
> > updates. Add support for forwarding database operations, including unicast
> > and multicast entry handling as well as fast aging support.
> >
> >> diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
> >> --- /dev/null
> >> +++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c
> >
> > [ ... ]
> >
> >> +static void rtl8365mb_l2_data_to_uc(const u16 *data, struct rtl8365mb_l2_uc *uc)
> >> +{
> >
> > [ ... ]
> >
> >> +    uc->key.efid = FIELD_GET(RTL8365MB_L2_UC_D4_EFID_MASK, data[4]);
> >> +    uc->key.vid = FIELD_GET(RTL8365MB_L2_UC_D3_VID_MASK, data[3]);
> >> +    uc->key.ivl = FIELD_GET(RTL8365MB_L2_UC_D3_IVL_MASK, data[3]);
> >> +    uc->key.fid = FIELD_GET(RTL8365MB_L2_UC_D4_FID_MASK, data[4]);
> >
> > Because vid and fid share the same union memory in struct rtl8365mb_l2_uc_key,
> > does setting fid immediately after vid overwrite the 12-bit vid value with
> > the 4-bit fid value?
>
> Change code to:
>
> uc->key.efid = FIELD_GET(RTL8365MB_L2_UC_D4_EFID_MASK, data[4]);
> uc->key.ivl  = FIELD_GET(RTL8365MB_L2_UC_D3_IVL_MASK, data[3]);
>
> if (uc->key.ivl)
>         uc->key.vid = FIELD_GET(RTL8365MB_L2_UC_D3_VID_MASK, data[3]);
> else
>         uc->key.fid = FIELD_GET(RTL8365MB_L2_UC_D4_FID_MASK, data[4]);
>

Thanks Mieczyslaw,

It is a little more complicated than that. There are three FIDs in a
Unicast L2 table:

RTL8367C:
        15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
        +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
Index 0 |     MAC Octet [4] (High)      |      MAC Octet [5] (Low)      |
        +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
Index 1 |     MAC Octet [2] (High)      |      MAC Octet [3] (Low)      |
        +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
Index 2 |     MAC Octet [0] (High)      |      MAC Octet [1] (Low)      |
        +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
        | S |   | I | L |               |                               |
Index 3 | P | 0 | V | 3 |               CVID / FID                      |
        | A |   | L | L |               (12 bits)                       |
        +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
        | S |   |       |               | S |           |               |
Index 4 | A | A |  AGE  |      SPA      | A |    FID    |     EFID      |
        | B | U |       |    (bits 2-0) | E |           |               |
        +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
        |                               | N | F |       |       | D |
Index 5 |           (Reserved)          | O | W | (Res) |  PRI  | A |
        |                               | S | D |       |       | B |
        +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+

One shared between CVID/FID (word 3), and two FID/EFID in work 4.

For Unicast entries, the vendor code just store CVID/FID in a cvid
unconditionally:

       pL2_entry->ivl       = l2Table.ivl_svl;
       pL2_entry->cvid      = l2Table.cvid_fid;
       pL2_entry->fid       = l2Table.fid;

Only for Multicast that it uses that condition:

       if(l2Table.ivl_svl == 1) /* IVL */
       {
           pL2_entry->cvid      = l2Table.cvid_fid;
           pL2_entry->fid       = 0;
       }
       else /* SVL*/
       {
           pL2_entry->cvid      = 0;
           pL2_entry->fid       = l2Table.cvid_fid;
       }

So, for unicast entries, we need dedicated fid/efid struct fields and
that cvid_fid is always cvid.

According to the delete method, the Unicast key is (MAC, IVL/SVL, FID, EFID):

    /* fill key (MAC,FID) to get L2 entry */
   memcpy(l2Table.mac.octet, pMac->octet, ETHER_ADDR_LEN);
   l2Table.ivl_svl     = pL2_data->ivl;
   l2Table.cvid_fid    = pL2_data->cvid;
   l2Table.fid         = pL2_data->fid;
   l2Table.efid        = pL2_data->efid;

The union just makes sense for multicast. The multicast key is (MAC,
IVL/SVL, VID/FID), without extra FID/EFID. The same delete code but
for multicast is:

   /* fill key (MAC,FID) to get L2 entry */
   memcpy(l2Table.mac.octet, pMcastAddr->mac.octet, ETHER_ADDR_LEN);
   l2Table.ivl_svl     = pMcastAddr->ivl;
   if(pMcastAddr->ivl)
       l2Table.cvid_fid    = pMcastAddr->vid;
   else
       l2Table.cvid_fid    = pMcastAddr->fid;

And without FID/EFID, we can have collisions between different bridges.

I'm also preparing the code for other families
(RTL8367,RTL8367B,RTL8367D) but they have their own problems. RTL8367
does not have a CVID field and RTL8367D does not have FID/EFID.
It will take some time to figure out everything here. And more time to
test it properly.

Regards,

Luiz

