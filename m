Return-Path: <netdev+bounces-43959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9567D59AA
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3060F2819C1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 17:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50503A298;
	Tue, 24 Oct 2023 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh1xQlAI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA627EDD
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 17:24:30 +0000 (UTC)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CFC122
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:24:28 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49d0f24a815so1758672e0c.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698168267; x=1698773067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jao6kpGym5ga8wPT9tk+CrG+dBzqzZE2yl0TnbxWrnE=;
        b=bh1xQlAIUx1iPmr2YXop8M3IMMEOjpnskTvttHk4fMqdQbHxGrxNK+NZX3D+1or9j0
         x1uD5OTWZl02cZhHQZR4MtP5vA3SxsMwGOzzxoLQwIuY7kibGMGcNa0AFIWhs1EGRhw1
         u2Ff5dMqFbOEQWSHDzybEYfaViSS1LJ+QWM5pB7x4OyJFrkoDtmSQnW3KD/OT40aiBt3
         Tb10pLS0Cv1PQItL3Z71V8WJGrPPjrOgzm45cu1BMuOPYGsil2b5h81NJWzT6mGcK+9J
         Uk6IjaqHkHXo1eYnF9M/YFa6ExIPKH/siHGZw1KW3Nczof3VgdiDMuiOnA4LCghPEBDh
         Rb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698168267; x=1698773067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jao6kpGym5ga8wPT9tk+CrG+dBzqzZE2yl0TnbxWrnE=;
        b=Sb78KfwPN+vYW14HcpqOA0lyX3tMBpJgmtm6+hOKYva+GuxrjqxQk6usUUdJhScPWm
         SBJa/azlPSnXWs6nFK1rm3/SESgQM43MsLCgLkWG1wbGdV39vePe2VcFrFCkiub8Aqd7
         ERqZZb7h0p2eFH1rpOLjrjwfWRwK6Mnm3Q46IkI881h3PciGwcSHHn+dZMB8pIbRy6MM
         l/RCLFCiPSxgCe/Vf2khIZL2Hj+P0UcGPIWl0Df4FcVmMUSN90DOZCHOWwsIc3coiReO
         vXJCbdB3I6VWEu4i86Ee9Y/3rJ7DPmtV86Jkd9gFBbmMe42lv8/6v9I1swl9HwSl0Ip/
         yK2Q==
X-Gm-Message-State: AOJu0YxP/Xj8tJzKJN3PppqWmlQCr9+O2NPt3UfvZvfYtkF16VsvNuh0
	vhkjKjAz9Us79ITUMqvMrXrCROFf3ydXPf6Yde0ENJsBrw0=
X-Google-Smtp-Source: AGHT+IGT0OT0/3P1p5NsSoxu773O+O+2eXk4OoM2yxQPxWPoqeuvhwzxpPpxNb20xMrD53AHe/lS4iWyI4FY+aMbctE=
X-Received: by 2002:a1f:2a0a:0:b0:495:bd61:a184 with SMTP id
 q10-20020a1f2a0a000000b00495bd61a184mr8308675vkq.2.1698168267604; Tue, 24 Oct
 2023 10:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b604dc470c708e1e70c954f1513e4b461531e7cc.1698136108.git.antony.antony@secunet.com>
In-Reply-To: <b604dc470c708e1e70c954f1513e4b461531e7cc.1698136108.git.antony.antony@secunet.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 24 Oct 2023 13:23:51 -0400
Message-ID: <CAF=yD-LUgdkZpNW9W2RV0f4PqYOkOCTRWGi6A7B7LZ1Q9bkM4Q@mail.gmail.com>
Subject: Re: [RFC PATCH ipsec-next] udpencap: Remove Obsolete
 UDP_ENCAP_ESPINUDP_NON_IKE Support
To: antony.antony@secunet.com
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Florian Westphal <fw@strlen.de>, 
	Andreas Gruenbacher <agruenba@redhat.com>, devel@linux-ipsec.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 4:42=E2=80=AFAM Antony Antony <antony.antony@secune=
t.com> wrote:
>
> The UDP_ENCAP_ESPINUDP_NON_IKE mode, introduced into the Linux kernel
> in 2004 [2], has remained inactive and obsolete for an extended period.
>
> This mode was originally defined in an early version of an IETF draft
> [1] from 2001. By the time it was integrated into the kernel in 2004 [2],
> it had already been replaced by UDP_ENCAP_ESPINUDP [3] in later
> versions of draft-ietf-ipsec-udp-encaps, particularly in version 06.
>
> Over time, UDP_ENCAP_ESPINUDP_NON_IKE has lost its relevance, with no
> known use cases.

I don't know how important this is, but a quick online search brought
up one package: https://github.com/rdratlos/racoon-ipsec-tools.git

Behind #if defined(ENABLE_NATT_00) || defined(ENABLE_NATT_01), so
probably there unused too.

