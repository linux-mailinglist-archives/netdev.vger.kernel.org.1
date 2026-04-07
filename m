Return-Path: <netdev+bounces-276154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEo5Il9l1Wm05gcAu9opvQ
	(envelope-from <netdev+bounces-276154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:13:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 028093B4677
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5A69305D71A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 20:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8280435CB60;
	Tue,  7 Apr 2026 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XievHkLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4180D338592
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592432; cv=pass; b=cDvzoEPX7zU0QFz0CjZywlgvzO+g5POTejfV6Xw+TQJ+zqYTj/gvdc34xpzEyrlnok7Z+ofbYqNGQItTXVHzLdR0LparDbUPy+JMjsBjxDUQxRNLhzu0Bua2fGJK9E1pCpqj3ImjTNk/iA0aLeADt46u8JJ5BebX8aprIKrEpeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592432; c=relaxed/simple;
	bh=e8wrO5vikecJwWYmKqPCipX+VB+wtmE5VFXv9Q/3tHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIvmPGxY/iiuMEsKLRn0Dn54YWSjNA6hIsrWqWlCGvS6kp/RgYAAFbCywhljFtAAMWfucruMZiKr6c7gKFbI+6DNxniz3GbeMI/NYFjjAxLxTAAfdN7t8SSzaLKOm1NPf5/CJiNEN1PicEbst6d6o3r0R/um2ROWh6uvfpntn3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XievHkLn; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501418152cso5233937d50.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 13:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775592429; cv=none;
        d=google.com; s=arc-20240605;
        b=TQvrZ3SPJSIfeZSciNONBIqJijUUg8SlWN52blpR0eOZy2V3NT4b0abOUKIOBwkDmD
         kZeZV0mu0O17gtTkWEJZ8SZiEY3962/eSAAsKOuhjfEaZtB1WnsnAmN9+v8KRLeTx/RD
         2a9vVhjfVUwuYJt7zGNDeoD0JT8WmNLBR4yTc7L4WYmnzJc1cuXSI96RSZE3Q9Rb8Aat
         N32BUrZEptPA2LxYZdsbZV9e834J+PZ/ZEvCvRWG+xWosJOxZ+GLfdTfDsXtYYSOtTVT
         +f6uAlE6ilpDa2pR+ZoLUdQtTWWChYgH4aZO+c79G8vj9iaADuDDEb9Bf7BsODFMqHEa
         2Pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lXMhraVxYqwinzEqyzscZSZwxhZ/frtE/tR4HTzvZR4=;
        fh=EP9iF1bhKD2WCTPFJA9RBaooJuDlCwVCMjlRb5nuam4=;
        b=GvXLHKBIky/A8P/NOiJK+6ZVoivuskoBxQmuipfYdikgBHqTVAyG/b7oROcDAwWu6e
         Wp5lLrcWOePzkm2hy2AHIbu7qtgHgn0u7bJFNmVtnoEXnyPqkd8hWLapcxQvo9WA9Eyb
         NkHfaEoyWU28pFFoxFttB5O1fDZacqqsPMAz/PQ4HdEZj+fvG0++kXtpFC2C7hyQNLh6
         0rUUYQCkR99O/m+loLpxZ32St/ZnunjpmC6w4fe2vR5SYJV1GPrJmksKzzIv1yfyb5Tb
         mfg87AxcIVG4PQpsRAjEJYBpjoqCvFsECQk5emTh4zDaV4nVuYzOPiv0PHZPr2UChOfG
         yY1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592429; x=1776197229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXMhraVxYqwinzEqyzscZSZwxhZ/frtE/tR4HTzvZR4=;
        b=XievHkLnOheSp2jIgR8kESbGKj6CngEzh/Mb8Dey29za/HJrCDQg2qhnais2SlgGsT
         UaCbedRWKPdMdRnyezUm8lA1rrg21G4VJiEti7B8MctxOPpz8yNajlEjI1pHVNli3bxP
         hXbRlHkQ7JCAO0Dk8eWfpypyvXOwwQd1S7Tz3pePpWaqHdNoUW8YLhHKnG0vIM489e0z
         CNB1+xA3NgU6P8lU005PRZVgFz6btE0HEqghbxjWeR+W2OJnI6yZybLOrmpHfMlKjFEl
         2OFtwh+xgt326yFwjeQ88zWM7q1zfYtnMookj0Xvxx75hoR6QoUv/zjuT/tZkn8LqJmo
         7+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592429; x=1776197229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lXMhraVxYqwinzEqyzscZSZwxhZ/frtE/tR4HTzvZR4=;
        b=LczshpXep89Ucw3L4sIMJMu4YE7guVHsmxmUXmTKwWlg7WGtRMJLIQ+AJrtZrJpAwZ
         dTKx5/EZ1YTvW3InPW6tQ+y8MYtC82wJGsEa8ZMqC/9A+ONhcf1Zm3cOVSqcV9Kwka1Z
         GzCBjsuhGYUs/xad2wCh+b9bkxiLyp9JpzPf9Fl5ze88Wu/aKFuqaQZhoine0O3+pbct
         IHZET/bm8QycBwSKwVvtBWf1Sc4KYNJJpfWpW1fAD1tFrmTla+sibnBilQU/ZbnM/tLg
         ylIXgsC98vBoP/98xUe1nA3a2soaqGHJFU2PS0uTLunMhaOa46DJ7RqycvX18+MxvT9v
         kqPg==
X-Forwarded-Encrypted: i=1; AJvYcCV74PrbBNCWC3Sjsxyp2y3x3pT4DBXLKwdtRUV6kr68r5PrTq7+s8WImyrBOYwwbdlVebQ8mZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlLLPvqy+Qf5x53rttE24ELRa1RjoMfPWN8bLP5yI2AVrPIczS
	R0tqkiN4qsGUayWlfUMOZcQyZrUzKIMxz2DPa+pbY5fmXI6/eckOGQT+0+TEFqVJ9W65LU5adpp
	4YeRcw/FvHhgMbQ1xj5YQ0ryCYRk1Z5k=
X-Gm-Gg: AeBDiet5qcfkK8X1OlmslMtqBqgtD+UfuzVtpYkivZsLDR7eWXwz8PkzRx01mBNVJZJ
	xjaxi1zozDngBTihFC08J6FQdaKjHP3yivk5orDMRvzEXAEqieTizVD9f9pPm5qsflI0TOPgHu1
	9ivgmdD+Yvlbe9xzvbJG+cXTEEILSiEn8PKNQdmp+xKCk2X7BYFyBo6qKwwgyRYzih9RPlr+kcH
	9soRELBvZvGXdEHTeQYasF/tVtMS6lZezTTHnoxclcOw7SIUHGtGw9tOjZ1JpYZax5iyG5vREBj
	sAny7MXJjQeOMBBpXnGQhsBlTsQBigOLxljhCDB5wCL3JDETcg8H4IEBx4J97Nw8XI31rw==
X-Received: by 2002:a05:690e:1447:b0:64a:e781:891f with SMTP id
 956f58d0204a3-6504878d8b5mr18273755d50.28.1775592429222; Tue, 07 Apr 2026
 13:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZ1FrL8qvvKuktBF@kspp> <d04e11af-5c1b-44a2-aebc-a0ee4fb79802@embeddedor.com>
In-Reply-To: <d04e11af-5c1b-44a2-aebc-a0ee4fb79802@embeddedor.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Apr 2026 16:06:57 -0400
X-Gm-Features: AQROBzBVPVG9lewQAg4xWgXaY_QVQNvPxJT95QjFDd687G3MpHiw6Ni_WDKPrq4
Message-ID: <CABBYNZKJ9Xqwo0CF8wwax68etv8DywG8BmN=V1CWoWcfiq2mog@mail.gmail.com>
Subject: Re: [PATCH][next] Bluetooth: hci.h: Avoid a couple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276154-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,holtmann.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,embeddedor.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 028093B4677
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gustavo,

On Tue, Apr 7, 2026 at 3:58=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi all,
>
> Friendly ping: who can take this, please?

Just resend as this is no longer available via patchwork.

> Thanks
> -Gustavo
>
> On 2/24/26 00:31, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> >
> > struct hci_std_codecs and struct hci_std_codecs_v2 are flexible
> > structures, this is structures that contain a flexible-array member
> > (__u8 codec[]; and struct hci_std_codec_v2 codec[];, correspondingly.)
> >
> > Since struct hci_rp_read_local_supported_codecs and struct
> > hci_rp_read_local_supported_codecs_v2 are defined by hardware, we
> > create the new struct hci_std_codecs_hdr and struct hci_std_codecs_v2_h=
dr
> > types, and use them to replace the object types causing trouble in
> > struct hci_rp_read_local_supported_codecs and struct
> > hci_rp_read_local_supported_codecs_v2, namely struct hci_std_codecs
> > std_codecs; and struct hci_std_codecs_v2_hdr std_codecs;.
> >
> > Also, once -fms-extensions is enabled, we can use transparent struct
> > members in both struct hci_std_codecs and struct hci_std_codecs_v2_hdr.
> >
> > Notice that the newly created types does not contain the flex-array
> > member `codec`, which is the object causing the -Wfamnae warnings.
> >
> > After these changes, the size of struct hci_rp_read_local_supported_cod=
ecs
> > and struct hci_rp_read_local_supported_codecs_v2, along with their
> > member's offsets remain the same, hence the memory layouts don't
> > change:
> >
> > Before changes:
> > struct hci_rp_read_local_supported_codecs {
> >          __u8                       status;               /*     0     =
1 */
> >          struct hci_std_codecs      std_codecs;           /*     1     =
1 */
> >          struct hci_vnd_codecs      vnd_codecs;           /*     2     =
1 */
> >
> >          /* size: 3, cachelines: 1, members: 3 */
> >          /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > struct hci_rp_read_local_supported_codecs_v2 {
> >          __u8                       status;               /*     0     =
1 */
> >          struct hci_std_codecs_v2   std_codecs;           /*     1     =
1 */
> >          struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     =
1 */
> >
> >          /* size: 3, cachelines: 1, members: 3 */
> >          /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > After changes:
> > struct hci_rp_read_local_supported_codecs {
> >       __u8                       status;               /*     0     1 *=
/
> >       struct hci_std_codecs_hdr  std_codecs;           /*     1     1 *=
/
> >       struct hci_vnd_codecs      vnd_codecs;           /*     2     1 *=
/
> >
> >       /* size: 3, cachelines: 1, members: 3 */
> >       /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > struct hci_rp_read_local_supported_codecs_v2 {
> >       __u8                       status;               /*     0     1 *=
/
> >       struct hci_std_codecs_v2_hdr std_codecs;         /*     1     1 *=
/
> >       struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     1 *=
/
> >
> >       /* size: 3, cachelines: 1, members: 3 */
> >       /* last cacheline: 3 bytes */
> > } __attribute__((__packed__));
> >
> > With these changes fix the following warnings:
> >
> > include/net/bluetooth/hci.h:1490:31: warning: structure containing a fl=
exible array member is not at the end of another structure [-Wflex-array-me=
mber-not-at-end]
> > include/net/bluetooth/hci.h:1525:34: warning: structure containing a fl=
exible array member is not at the end of another structure [-Wflex-array-me=
mber-not-at-end]
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >   include/net/bluetooth/hci.h | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 89ad9470fa71..572b1c620c5d 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1468,8 +1468,12 @@ struct hci_rp_read_data_block_size {
> >   } __packed;
> >
> >   #define HCI_OP_READ_LOCAL_CODECS    0x100b
> > -struct hci_std_codecs {
> > +struct hci_std_codecs_hdr {
> >       __u8    num;
> > +} __packed;
> > +
> > +struct hci_std_codecs {
> > +     struct hci_std_codecs_hdr;
> >       __u8    codec[];
> >   } __packed;
> >
> > @@ -1487,7 +1491,7 @@ struct hci_vnd_codecs {
> >
> >   struct hci_rp_read_local_supported_codecs {
> >       __u8    status;
> > -     struct hci_std_codecs std_codecs;
> > +     struct hci_std_codecs_hdr std_codecs;
> >       struct hci_vnd_codecs vnd_codecs;
> >   } __packed;
> >
> > @@ -1504,8 +1508,12 @@ struct hci_std_codec_v2 {
> >       __u8    transport;
> >   } __packed;
> >
> > -struct hci_std_codecs_v2 {
> > +struct hci_std_codecs_v2_hdr {
> >       __u8    num;
> > +} __packed;
> > +
> > +struct hci_std_codecs_v2 {
> > +     struct hci_std_codecs_v2_hdr;
> >       struct hci_std_codec_v2 codec[];
> >   } __packed;
> >
> > @@ -1522,7 +1530,7 @@ struct hci_vnd_codecs_v2 {
> >
> >   struct hci_rp_read_local_supported_codecs_v2 {
> >       __u8    status;
> > -     struct hci_std_codecs_v2 std_codecs;
> > +     struct hci_std_codecs_v2_hdr std_codecs;
> >       struct hci_vnd_codecs_v2 vendor_codecs;
> >   } __packed;
> >
>


--=20
Luiz Augusto von Dentz

