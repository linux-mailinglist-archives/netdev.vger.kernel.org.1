Return-Path: <netdev+bounces-289975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCAfMwPIDWod3QUAu9opvQ
	(envelope-from <netdev+bounces-289975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:41:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17F58FD4D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF62F30F8F42
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E433EB808;
	Wed, 20 May 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvSBjbOe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5A027B353
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286815; cv=pass; b=LcVkuiGYJ5BOhr1/YBJ2Qf5Y4KLmH5MYEFFoa8PfTsuHcB9R8fnzLrNXFMcjkcxz1d5BoB6jrMNewq3Tgbukxh+GV15Z9bar51NIpt3Dfy8avVwRI5nHZXI0IiPeZ5lhl2ifBrlQzNSyjlkPG+vcpJ52Sq1taj6lG3amnWXI7DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286815; c=relaxed/simple;
	bh=DCU90GwE/ZuwHdPi0QTy9yMdv9sIhc+WGo6IzUy2AFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGVENYxYZmA/XScuzcItsDf9KcRZ68dnRs6UU72ezFHx1S3KqdZgBy6GoeWCI0CKrp+u+h0oX36MXQSh7pqHXBUAGltlvt0412koIhqzfUYfboV6imoYMNuPo6audrUIWGhBzuV+XWpCclMRUQNFNW4zKHR89Ju67KgYBD9Vgb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvSBjbOe; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f68f3b075fso2419967eec.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779286810; cv=none;
        d=google.com; s=arc-20240605;
        b=bdDbDH9glLIFhdn7zSA5bL2CtQJdci+jQLbFULFlGmuPdqrCrZJNvDM1xxaT3Glse3
         xshhsAOp19dE2nKTVKkssJ3Q/1xondnQ1/lVdNJrr2tJTxKW8BLnWLJFCf9Ok8wcm4fh
         tah8F0DLcYAK51uOCcXZY9NKExPAuKEHZXBf5XxiWf12jutdwX1Wn9lgGPys058aDJR1
         ALTBrR6tWIzUB4cnXzFzDD7nouut5rw32kAKj07sBqH7W2443kx22tUXTKTO0tTMGqls
         UY/2JodKI7+hdQL40AQJ8eVmBlC1c8Kgjf2Xbq1vvijZ83NFmwnic+nLTcdDoCFOO5JS
         z2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VFiB/PW9sQR0VXs4DboOpTUqLnAoFKcFHc55VSpyjYo=;
        fh=hmhJ/Oergd+8dzeYT3s7s6hzKGiSbgE+u+IldxOc9wE=;
        b=Posga0UmZhG2CtWCZzq+C86mj9FKh0hNDCXiDSV1mfvea6euQXxAj2tidShx+S0moR
         npcN1Jm4pP42l2wIQ/oHLDtdwUwVO2tO+UJnkrn7xqL7FKjXNS3zwXbzFHee1bSfrz5R
         x+v0qDX2JMi0Hd1RTciDsHUlsZVyePsnyj9YP85Wxeo2SsJhZYD3BioUsBxTf9lMp2e1
         RF/QEVU4BRy3D4/U7E3Vp+Y5ojmqV3ZFX18fcRL6dC57+nno8d4GursdDtrtx5T5zcod
         2yHKah5SiOtbQvTwFewlKPrfRrFqBgfEG74C1zv5tBTxCNQn4D3AhPSicpAp00B+E0s8
         /Xlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286810; x=1779891610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFiB/PW9sQR0VXs4DboOpTUqLnAoFKcFHc55VSpyjYo=;
        b=dvSBjbOegkV11Sojui1nGLWgCKpBSEl/vCrfsV/O7M6e4fTAdvKUp78nx7BCzxd3hP
         IkZIEXQJKNvAIfyHzm9f74t1LI/bS++sZYer+dCvKpBp0mb7+wTHu5NjLPKdespoU2A2
         IL684wnlw2xb7m240HOAn2aadL7DboLMYN5KNEiIIBB8+Lg2f2m65wPEvDOJbiPlDMxw
         xAwiUPdmG+WG2+P83GcWoWknurCLlT0YIUG6BEo82L+i//xPD524Uf/+4Ipwe9pfyd95
         8MkebDlongB50ysuZ5LHCiIPEbWdD2cul8ApW1XI5KmrLoHE621g+h73mxUKromYHJ0B
         TmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286810; x=1779891610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFiB/PW9sQR0VXs4DboOpTUqLnAoFKcFHc55VSpyjYo=;
        b=T8+EK/Z2VgALYzwMR1n1sxQaO041THOzpgAi0PqhYJnYomJKDYoV3ccPaucLCYAxVb
         q4SL1VS6vcWXpnnWxpIlg35BFr22iglu49PnFO4To8TLkIm2aUH7V2+PN15djxw6EYIp
         UdE4yGcdXNKGmElXOIFcrrUBBF2qE0oy7O7KPZfMFII5gwjwFYlOirz1GDi23mXCr2R9
         M8GvbFcfOTanygcyyzRNCzu/8Ts/Pn5NlgNOouMDLqb9P1RO921/UdIhUsQaw5L0KrLI
         RfIV6gidcSLAkKjh+f6ZzdyTLvG3bFD6vSjkBLBRHUGlkaA7Z1i2YzPiNeJhrfyL4Jsw
         xPhQ==
X-Gm-Message-State: AOJu0Yxx34l2yQSBexYzVwElZ7u+degu1+Rm1aC0jX63WZ3pEQdibEWs
	S3DxKXJnHVq+bo29TCn9h21EkOdpLS36nJLPTuUYYu8UrjckLy1K1zj15oin1GX67xkIVkyYiWA
	ZLcI0x1tMx94xFffIiAQ31ZJeqy1y2bI=
X-Gm-Gg: Acq92OF90t/bRTiBZ2sw1iYLwiG7rbqon+rWxtXAuN09NRMdIdP571HIcvuj6YDDdJr
	yjmiQEaG6CsHkoVeVTFKmdM9W7gV7LPaqD6Y5uE+9FPQq8jyUwy15Qwf0ufCiYB3ZPdF1dJ18CO
	4/1tAYy8T0sYaShkMSrQX84HFKV8n0qUBlfMSpSwvqG5maQCXtxLNZ/a4AS+TVo3TRDnYR/hucD
	PC6EUON4uPAUNYKlYkmbw7koqwRMJqDBHPhv0mvSzrChr1aERKX51b9RI3fm1Y4w/V/ljQCiVug
	TisXRrlEpnWOM/NuOCbhEpInJw==
X-Received: by 2002:a05:7300:3722:b0:2c7:287:6740 with SMTP id
 5a478bee46e88-30398659f10mr12852905eec.28.1779286809772; Wed, 20 May 2026
 07:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515230516.2718212-1-dhowells@redhat.com>
In-Reply-To: <20260515230516.2718212-1-dhowells@redhat.com>
From: Marc Dionne <marc.c.dionne@gmail.com>
Date: Wed, 20 May 2026 11:19:57 -0300
X-Gm-Features: AVHnY4LZyU1fN0nLufEfK7ShUQmMFjrVSYIn74dwF45VhlPQ7pv5rafuxGEYCfY
Message-ID: <CAB9dFdsSi74U3PXqY1Ay3tCc4WYkhbUtmBQqs7ntnOSsVfKRKg@mail.gmail.com>
Subject: Re: [PATCH net v4 0/3] rxrpc: Better fix for DATA/RESPONSE decrypt vs splice()
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289975-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marccdionne@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,auristor.com:email]
X-Rspamd-Queue-Id: 2B17F58FD4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 8:05=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Here are two patches containing better fixes for the in-place decryption =
of
> DATA and RESPONSE packets that can corrupt pagecache spliced into UDP
> packets and sent to an AF_RXRPC server [CVE-2026-43500], plus a patch to
> precheck the length of rxgk-secured DATA packets.
>
> Of the main patches, one patch fixes DATA decryption by having recvmsg
> unconditionally extract the data into a flat bounce buffer and, if need b=
e,
> decrypt it there.  It doesn't seem to cause a performance problem to do
> this even on unencrypted packets; for encrypted packets it makes sure the
> content is correctly aligned for crypto which seems to get a small
> performance gain.
>
> Further, it means that DATA packets are no longer copied in the I/O threa=
d,
> avoiding a slowdown of the protocol engine that runs there.
>
> The other main patch fixes RESPONSE decryption by having the connection
> event handler worker copy the data to a flat buffer and, again, decrypt i=
t
> there.  This simplifies RESPONSE handling.
>
> With these two fixes, the data content of the received sk_buff no longer
> gets altered.
>
> David
>
> The patches can be found here also:
>
>         http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git=
/log/?h=3Drxrpc-fixes
>
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> ver #4)
> - Updated to current net/next, dropping Hyunwoo Kim's patch.
> - Don't allocate more than 65535 bytes of buffer so that ->rx_dec_bsize w=
on't
>   overflow.
> - Fixed Sashiko review comments[3]:
>   - Fix incorrect ticket length limit.
>   - Don't need the MSG_PEEK limitation; can avoid this by checking seq of
>     skbuff being recmvsg'd against the one on record for the content of t=
he
>     decryption buffer and (re-)decrypting if it doesn't match.
>
> ver #3)
> - Fixed Sashiko review comments[2]:
>   - Fix wrong abort codes.
>   - Fix skipped rxgk_put.
>   - Fix some mis-sizeofs.
>   - Fix flipped length check comparison.
>
> ver #2)
> - In rxrpc_verify_data():
>   - Flipped the order of the buffer size comparison.
>   - Used max() not umin() to calculate the minimum buffer size.
> - In rxrpc_verify_response(), returned -ENOMEM rather than uninitialised
>   ret.
> - Removed the xdr wrappers that were added to make backporting easier.
> - Fixed Sashiko review comments[1]:
>   - Added length prechecking of received packets secured with RxGK, there=
by
>     avoiding looking at an unallocated buffer.
>   - Added missing crypto free.
>
> [1] https://sashiko.dev/#/patchset/20260511160753.607296-1-dhowells%40red=
hat.com
> [2] https://sashiko.dev/#/patchset/20260513131941.1439155-1-dhowells%40re=
dhat.com
> [3] https://sashiko.dev/#/patchset/20260514155304.2249591-1-dhowells%40re=
dhat.com
>
> David Howells (3):
>   crypto/krb5, rxrpc: Fix lack of pre-decrypt/pre-verify length checks
>   rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in
>     recvmsg
>   rxrpc: Fix RESPONSE packet verification to extract skb to a linear
>     buffer
>
>  Documentation/crypto/krb5.rst |  17 +++-
>  crypto/krb5/krb5_api.c        |  54 ++++++++++--
>  include/crypto/krb5.h         |   9 +-
>  include/trace/events/rxrpc.h  |   1 +
>  net/rxrpc/ar-internal.h       |  14 +--
>  net/rxrpc/call_event.c        |  22 +----
>  net/rxrpc/call_object.c       |   2 +
>  net/rxrpc/conn_event.c        |  32 +++----
>  net/rxrpc/insecure.c          |   8 +-
>  net/rxrpc/recvmsg.c           |  68 ++++++++++++---
>  net/rxrpc/rxgk.c              | 160 ++++++++++++++--------------------
>  net/rxrpc/rxgk_app.c          |  46 ++++------
>  net/rxrpc/rxgk_common.h       |  66 +++++++-------
>  net/rxrpc/rxkad.c             | 115 +++++++++---------------
>  14 files changed, 309 insertions(+), 305 deletions(-)

Looks good in testing.

Tested-by: Marc Dionne <marc.dionne@auristor.com>

