Return-Path: <netdev+bounces-19427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6775AA5C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63609281D06
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A8199FA;
	Thu, 20 Jul 2023 09:03:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D04361
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:03:47 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A3493FB
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:03:23 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5768a7e3adbso25666957b3.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689843740; x=1690448540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/vhm/jQR+pTUrXfHHmsjiZUpZ/0H8O95QB5uTV0BXA=;
        b=pQ4ITB6jYHxFYCiQNkTWLLjTCWSE+nX9p5L0WiM5GAsAwJ5a8YizfSB2tRweGAouDt
         njYyv2+YPUtBwwFial0g1YfkFjT4zliHGmeBSj7emOzZYdgfcbX3r37McO9Ju0ctB5jC
         LAH/V/YNiINil5Ui82I+yk4+P1xPvPi9cwLQdJsXp5F5rb6hUhSfFygGfwsUa4mBRPfJ
         YTTzUHCXKHX9ZIC2egAJgzUgPLp2aRqayV9ktiCm0p0ZdsjHN+/NFBCYl1qzCLczgEKP
         DEyFHztcL8tAuT5ltTbj8NOVIehSc2QHjRHYkCEx3SLZHkTNmZakd61LbPkoNCcdlo1S
         qJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689843740; x=1690448540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/vhm/jQR+pTUrXfHHmsjiZUpZ/0H8O95QB5uTV0BXA=;
        b=Sx8vhVMav/VKBJvG/gybGdDV9+M7z7qKYMMYKLN+SrKNgyH9GPDsduxgTMDMvpOG/E
         5smKBto3CkW2wjS9MqDr9/kxKZcvcvQyWY2ZST/vDS/zdOv1Xkl0XP6kk45UhMpOvaT4
         zO++yo+/PDxF9IHokrtwP3+a5xnJ6fnGdVdqH9kg53BXTXB+mgqzxIeDISeH0NKd+zx3
         tMbCxDVNZvl+XZd4xo5CchUCL5D17Y3gwvtn6VRNYUeByx/Po+DcmrF94B26DBZQehfn
         oTtu9rvUDvwxo7vr505dyaHDC1ULgOuIGX0GMYSEyX+wlVzoyPZuj/Am6+DDbvFU51gp
         kG1Q==
X-Gm-Message-State: ABy/qLYmTjuC1dQK4oAK+/kwKJyztFuiwz4XkTkJeR3gfxidRzwsMVWo
	MMZlfEXL7dWMxm3DaKYNmvPk2YRFhRgcMDzfVcI=
X-Google-Smtp-Source: APBJJlFAaFNJ42DtkR4LrSujYZbiwuQBDDE+KrIyFdcKcQuAbS1m+5aC7oHX53q4p5LAgRI/pIRZJkQiaPc7YSrC7sU=
X-Received: by 2002:a0d:e602:0:b0:577:3d6d:a95 with SMTP id
 p2-20020a0de602000000b005773d6d0a95mr4856387ywe.6.1689843740262; Thu, 20 Jul
 2023 02:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0699747bc9bd7aaf7dc87efd33aa6b95de7d793e.1689677201.git.jbenc@redhat.com>
 <CAHsH6GvCEusX1Uuy7tk7Do-V0xDQRB+Q45UCpCjOeUV0=GFfzQ@mail.gmail.com> <20230720105047.18dcc5e2@griffin>
In-Reply-To: <20230720105047.18dcc5e2@griffin>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 20 Jul 2023 12:02:08 +0300
Message-ID: <CAHsH6Gu2XwmnjyvQy--2=2KGOpPgVCwyNeR5q3+vR_+m6yASkA@mail.gmail.com>
Subject: Re: [PATCH net] vxlan: calculate correct header length for GPE
To: Jiri Benc <jbenc@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 11:50=E2=80=AFAM Jiri Benc <jbenc@redhat.com> wrote=
:
>
> On Thu, 20 Jul 2023 11:43:05 +0300, Eyal Birger wrote:
> > From looking at the geneve code it appears geneve would also have this
> > problem when inner_proto_inherit=3Dtrue as GENEVE_IPV4_HLEN includes
> > ETH_HLEN.
> >
> > Would you consider adding a fix to it as part of a series?
>
> I can look into that. I wouldn't call it a series, though :-) Let's do
> both separately.

SGTM. Thanks!
Eyal.

