Return-Path: <netdev+bounces-63462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893E682D201
	for <lists+netdev@lfdr.de>; Sun, 14 Jan 2024 20:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400A11F2146D
	for <lists+netdev@lfdr.de>; Sun, 14 Jan 2024 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79AA107A6;
	Sun, 14 Jan 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnsVeWbK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75949F4F3
	for <netdev@vger.kernel.org>; Sun, 14 Jan 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3ed1ca402so74360615ad.2
        for <netdev@vger.kernel.org>; Sun, 14 Jan 2024 11:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705261603; x=1705866403; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aTVp/I/oAKbZ+xp1WU89s2iOH0M0j6SA83ty1QRiVw=;
        b=hnsVeWbKLyozH5Hp0PyxkwbQflLXgS8uJ3CA3v/OokEeTfWdzFq53zBqk1Hp4a4hXo
         iGYAoVyWBZOq8GPlzMCsWO2ELrWclTOXFOME7Djncgu2osCKDtsxAVB359lq0Uncf+wH
         IO58hkIhDC8SNPbBkfCqNfuHI8Wz/XAk7JTkhRSlpNB0z/d064Z3FK7kLG/tOZbRi8T/
         CH2RJvo6C6sxDZ2WvkapCpketl2NimuOFZ225xTlov+9wgAd5WdsBU2DisrBx7o2dETh
         eQ1bCUkQrL9AmiUOMEoyzSudFtOvTB57+TV41n4joOvz4qHpsHJ4he0E9V7TjViPhzfr
         jjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705261603; x=1705866403;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aTVp/I/oAKbZ+xp1WU89s2iOH0M0j6SA83ty1QRiVw=;
        b=XWqCm09x2ybgHGNC2eXTv9xnuqGqsUYGkMsbLUJE6e0hxc5mxHwNVP2M9GnOv27JTi
         wFBo25bOCBYoygnnECJrmCfRnDgVtmgbr2huQFnA0CIBG0WIWprOPIHTu+VdbKznEImI
         yTArBLGB5YI6CRpbR2xn+MKC4DY/0XC/YCz8BZ7NuX3jn/l3qkmabkrDLr5CvJ8bk3ZE
         bVsh2JEGzd3P0O2ljKoknpJpYdtmNYO4Qd3H++AyDhbKxqqeBaTOjWCZKsb8lPIdXYhR
         jbdCPxOZEb3KklIte8D/AF1JGxcEXhbE6LXq+BbmbtiLnJYiiipuZWPKzSkAPrsT9j4w
         nooQ==
X-Gm-Message-State: AOJu0YwdpdTiXFID0yW0O4+bHr5N63GFynpumVxCsnbwEwZIl4GtyOnE
	+kuv5913UqN8rICkkiNToT/doh04/EymcdlaLMSAVuy1sl8=
X-Google-Smtp-Source: AGHT+IHIGyTCEYQjVvoEqMvEfb/L55YNuizxoRCOq6n+N7H8ZP5c0IpGN7q3AmJWiIdmgjNDKaAfNcgIUSJcqNmh78o=
X-Received: by 2002:a17:903:607:b0:1d4:971c:dc18 with SMTP id
 kg7-20020a170903060700b001d4971cdc18mr4400432plb.30.1705261603305; Sun, 14
 Jan 2024 11:46:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC-fF8Sv3rEx3-st-vHWqcOGerSN66-6qv4Xv1Sh2wDLQ2yNmg@mail.gmail.com>
 <CAC-fF8TCqQ4oejHjFZPHqcNRqY5WQLzynw+KoaOOvjv8ZZwObg@mail.gmail.com>
In-Reply-To: <CAC-fF8TCqQ4oejHjFZPHqcNRqY5WQLzynw+KoaOOvjv8ZZwObg@mail.gmail.com>
From: Isaac Boukris <iboukris@gmail.com>
Date: Sun, 14 Jan 2024 21:46:31 +0200
Message-ID: <CAC-fF8Q8UQuZkHBynnQwoB_S2eCg2yvR1zwRh9YCX3TT=31b2Q@mail.gmail.com>
Subject: Re: TC: HTB module over limiting when CPU is under load
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 3:57=E2=80=AFPM Isaac Boukris <iboukris@gmail.com> =
wrote:
>
> On Fedora with the aforementioned openssl command for load, i get
> ~1400kb with HTB (compare to ~400kb with the older kernel), but when
> instead i use stress-ng command for load then HTB only reaches
> ~1100kb, while HSFC and NETEM still achieve ~1800kb in all cases.

Ah my bad, should have read the tc-htb man page to the end. The HTB
module also works well under heavy load, if I add "burst 128k cburst
128k" to the tc-class-add command.

Cheers

