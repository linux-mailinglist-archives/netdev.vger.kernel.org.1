Return-Path: <netdev+bounces-252930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HoMITDGc2lZygAAu9opvQ
	(envelope-from <netdev+bounces-252930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:04:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9A79F2F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90E973022936
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E7022FAFD;
	Fri, 23 Jan 2026 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="a76aEvk/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD082BFC7B
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195050; cv=pass; b=MI1Z6VI1UssFP/It6QiH1vJ8ZFV5XQ5sHOZmMwILEP6owFNN+wjp40eULG4LgKq83VVvxlNaYSIc5pVl2OLG1FA8TQhn5MyNePVvYalRv6Ei9CqrnvqLcC6N7RiTOp446tOdsb2k6N5znCTpfz0iTj8dXsVajJa6AztEBiSBs00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195050; c=relaxed/simple;
	bh=CpPvjgcDkDqSArkrMVfddRMNVtpHT5NBrTux1IN+Eok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jW/DZbr23BcBO0B1OBCjeve46GkOD94L9Hg3TX9Y1/EQmIqguu1wDddgX0+kaFmrMfG1t/kVncsbAZ4t2gjT4Vkifjjcv78Iuyy758AGAnh0+N6C5XOA0SMkCFIsa6L4T3fUAgqQepmxZxLt/gF9k474qFj8rE6+YEofpXVuAkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=a76aEvk/; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5eeaae0289bso2227761137.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:03:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769195035; cv=none;
        d=google.com; s=arc-20240605;
        b=DFHFUndaVJhz1lviljjFCcelZAylfc8eW51HHtYoRycR+Kbd8zpGvVg4ZAXlnddZg4
         y3uE7So0ePlhfeUtn8bb2n28rz2XxXozujmiiAvtbfKtHX57S1f5Pr9vc4qqivDidr6v
         rnuZnBQ4LfI4NHCY3JZ2X3EdzsPjUEG3lfkqn5dDk5MazJCAwDyhUR+AKwCst7CKU44+
         ohjkvPJPL6mrvTldznfS29Bi7Q5k1xLAY71FJfvP77N7faEXbPfOk9oMSUTUIdujryrC
         aLdaQeOnyCm/+m/9pymQHzrDdbnP6MiZ+54Q52bdNsUwggAfQekDJUO3SvGlMkbVTs8u
         wyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CpPvjgcDkDqSArkrMVfddRMNVtpHT5NBrTux1IN+Eok=;
        fh=6NL+27sIBxvB5wwZ0ZBQmTcL/aD2DfokudLcOu/BOqg=;
        b=kFRxOAExAw+0w/vVmmDJ2wTTxtTiy1TmanJOxVajB+jp/ZKmmoUVy1Rw9KwaObCcpn
         dvCLFIHXxc6B3jM1X2ldC2qzBIw51LCRkTJ4P8Bf3rCfM7j7kNPyhQK7rtYSVs9VPz00
         a+urxOuw0AnTSW8C9pYq31dzwB57+bqpP5cha+s+BXG35YKOUMBHu5IK+82lXzv7K5B0
         7zpAlQ5Pm9iQ2CuFyxeCVb/goWKWBN8GBcMc7gJrIddWpuGTE9WRj6Ij13oY7JVW01BE
         tcmuczQklIzn/IwDU04to2BCMmCWGdW5WjdjtG8XH7GymSJsiZA7/NK9yrR8b8uoOgD1
         yoLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769195035; x=1769799835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpPvjgcDkDqSArkrMVfddRMNVtpHT5NBrTux1IN+Eok=;
        b=a76aEvk/6QxIZstcHCl9ERvuo3qqforU5djafLVD7zey2Zo36hs5Xxw9Fz/QRe/QLu
         X7H/c0JrYNIMPnLtZLXtrkpSgv+pVbYe3gSknLx42PyMcTDZ+h+sHgYC6UXFQLPYDq1z
         Vc7sX/C1va7nB1JtQHKdzdC2i6ibZbm7uWwtQPY/E7MvE//xy4ofnZAOHfnQJntLSfk2
         QNzQVG+BVwOCeyzkMrWlkC2FkArvpDpwiPeH76mhoZJJTksSy4HuUf9An0FpUvONMNze
         7YMJGXH5M5W5ISasZ9Skd9mm1SN5yI2Lfe/NkRsbzVkeq5NLf9dzeJvZ7e1czSdta0LZ
         9d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769195035; x=1769799835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CpPvjgcDkDqSArkrMVfddRMNVtpHT5NBrTux1IN+Eok=;
        b=DdykQ+bNRVDC17FNQUGkSvC/bWs8pTShQcr66gMMxSUDeK8JziJA9LRFV8eam6zcDr
         p4VE0yAEGmAy4bPwBGTLB4fr4CzmTA+q0si6iYPKW+NH15msbKRHhVha0w4YVWo+6F4+
         vf7LGu6pSoeiFjoZv21zo3FwFgqKe63lM0PkU4WFnKASkP7HwFT8t+/jQZp6bVPpJkqR
         zwoJmntSuIwTA5QgXntqdEjdp3IPL4TqYfCdVsDqj8Mgu+f2lva4irLfgBtreP6i41tq
         8cfGQ39jCa11iTXaYfxRA9lGDZ5XP/PtQm/6PVNBO0qJHaSBsnUQhBCTbJDdHG1hqIgd
         /D0w==
X-Gm-Message-State: AOJu0YxMag81VhxtoX2AatZ7Qbj9M+bshikqMtAcPOkQNHpKGBRo5K/v
	rhUig1maqDCzyRz+HOcZSHtMgxEuoxY9eGFOGzDdABJHmBvlZUAtdojMyggAyMKyd4+RA4trtHt
	GiAAQszAk0cg6HRUD4BZWHeZxbpe7KVdjbvnuKCASvw==
X-Gm-Gg: AZuq6aJlrKwyV4X25SKSlFr0BjX4iHukyi4fPcUYaBpXJ1sD0B5NNd8YTLTu4g5DTAp
	rnmQuqm27UkXcTazaGK9aJlxHWXyk6DITWWiIkuhaMPVXSWlCAl0RRQp8jmR1S9pAgQhw0E6HIv
	zgDuqaF9aysdiqdYgm/OB03fL9kICb3pIpMz07FBtu4xlWMGGLYXAger8CorUgb/v1ON43masks
	wXhSRazyn9VHA4jsNDoD3DDA2Ov2DlGSSf/xSicSs3sygL9gUzcYttrvHPv5u9K2RiKjr40jNek
	5YmqLQ==
X-Received: by 2002:a05:6102:3711:b0:5f5:2e63:f574 with SMTP id
 ada2fe7eead31-5f54bccc597mr1367532137.29.1769195035232; Fri, 23 Jan 2026
 11:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122192851.86670-1-rjethwani@purestorage.com> <20260122174821.70553ffc@kernel.org>
In-Reply-To: <20260122174821.70553ffc@kernel.org>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Fri, 23 Jan 2026 11:03:44 -0800
X-Gm-Features: AZwV_QgSp3VtJG9yElhjidN6-vlCpeg2XxHFMggtIy91vD9gzmGI6xWcbmYKjAs
Message-ID: <CAKaoeS0f7z_pjJhij8dFpgPPJfiWGsn25k6rgBUMUM4wiFHurA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] tls: Add TLS 1.3 hardware offload support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252930-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,queasysnail.net,davemloft.net,redhat.com,google.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,purestorage.com:dkim]
X-Rspamd-Queue-Id: EFD9A79F2F
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 5:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 22 Jan 2026 12:28:48 -0700 Rishikesh Jethwani wrote:
> > - Rekey handling: HW offload key update (rekey) is not yet supported.
>
> Not sure this series will be merged without rekeying.
> We'll need to discuss pros and cons.

Rekey support is in [PATCH v5 2/3]. Split into a separate patch to
make review easier.

> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> > Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).
> >
> > Both TX and RX hardware offload verified working with:
> > - TLS 1.3 AES-GCM-128
> > - TLS 1.3 AES-GCM-256
> > - Multiple KeyUpdate cycles (rekey)
> >
> > Test methodology: ktls_test : https://github.com/insanum/ktls_test/tree=
/master
> >
> > Please review and provide feedback.
>
> Selftests are a hard requirement, I already shared a link with more
> info with you.

I will run the existing TLS selftests to verify no regressions.

