Return-Path: <netdev+bounces-47104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D227E7CAF
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 14:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EAD1C20AE5
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E11B268;
	Fri, 10 Nov 2023 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WevKgGf8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916531B291
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:54:33 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0F938223
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 05:54:32 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-da041ffef81so2305422276.0
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 05:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699624471; x=1700229271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/LbpfwaJPf6ubPAPHPmb0BW4zTAaaLheKUet17n20sM=;
        b=WevKgGf8wzcaAnDYx3rzqiD656ySUgXqvvrq9JtFSmKCiTRL51UXoFGGBP79xvyfeT
         3umIgz3IBgpqwuB83PCOoQIsGPVQrjGkpLcpQY+4D+i+TLVtztykYJhUNIh2LndZ8AQU
         cGzqCN6lZyAkZKF+arM4IJkoibJmwI9UcdR1J0Yntiz+MZsRa2htALVjTfvh3H5HYLk7
         K1DLUbRJ25Iv763iveIUHYWp5YpCiU5aLtCFBeRTNYrKurTYvQ490Zx5Al70TwLOXmFW
         Vdy5MYanea3hI2fgz81rbN2TW3g34rUOaOPj3/tClJAQcZ35MYIbznnIjsHNyiHMATJu
         CoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699624471; x=1700229271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LbpfwaJPf6ubPAPHPmb0BW4zTAaaLheKUet17n20sM=;
        b=ucc3HyxxrJSQ5Dw/ktZsdH2BfV2FC90cTyHmpj5fnDaoVv+Cm3yaYvpnAkQZTNyefw
         V4PJEMXlfrEIytJ9iieszyjOzEPGitHxnWAhkoYvF1fuwMtrpgmo2wcHr81WehhGBJHW
         GbFUvsURUL3rA8I0vMYC89TiF+E0D12Gr36Uw6SdfrodTk+XdmS61jylRDufY8ND/S32
         PHypplbGW2qIyei1juwTaTRhRJuGzjtwYxDQ931pEZe2twp90oZYaloQxoxVXqiJ0dCm
         HLoSjFx5WnLKufnrBTIhZ0aeO8Rrk7DfKc7TVfXCIOyoeM95ZTvfwFnJrj8V5CiLYChq
         KjtQ==
X-Gm-Message-State: AOJu0YxW6zzYJX+gL/4XBryIiEXhepU1j19ZO8EU98E1bceeLRd4hfm0
	vwFNbRGmrsaV5y9pW7ZOvkIPmO9GjGJ0SxAAJGU=
X-Google-Smtp-Source: AGHT+IEUK+Vbw3oKVcQdqGPSKFRJWXKWmKE+rxHVbO94r98n8HGHJ/LxrpJi+S3Gee9/ZK3/nLCZpDXplJow+Po14Ww=
X-Received: by 2002:a25:a1ca:0:b0:d9c:7d7d:1ac9 with SMTP id
 a68-20020a25a1ca000000b00d9c7d7d1ac9mr7009833ybi.14.1699624471273; Fri, 10
 Nov 2023 05:54:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106001410.183542-1-luca.boccassi@gmail.com> <87fs1dyax9.fsf@nvidia.com>
In-Reply-To: <87fs1dyax9.fsf@nvidia.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 10 Nov 2023 13:54:19 +0000
Message-ID: <CAMw=ZnS-9S6Whkz4WX2SeckwqmSqmAnhqS_yFoyV5Q_5_dmvkw@mail.gmail.com>
Subject: Re: [PATCH iproute2] Revert "Makefile: ensure CONF_USR_DIR honours
 the libdir config"
To: Petr Machata <petrm@nvidia.com>
Cc: aclaudi@redhat.com, netdev@vger.kernel.org, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Nov 2023 at 13:51, Petr Machata <petrm@nvidia.com> wrote:
>
> luca.boccassi@gmail.com writes:
>
> > From: Luca Boccassi <bluca@debian.org>
> >
> > LIBDIR in Debian and derivatives is not /usr/lib/, it's
> > /usr/lib/<architecture triplet>/, which is different, and it's the
> > wrong location where to install architecture-independent default
> > configuration files, which should always go to /usr/lib/ instead.
> > Installing these files to the per-architecture directory is not
> > the right thing, hence revert the change.
>
> So I looked into the Fedora package. Up until recently, the files were
> in /etc, but it seems there was a deliberate change in the spec file
> this September that moved them to /usr/lib or /usr/lib64.
>
> Luca -- since you both sent the patch under reversion, and are Fedora
> maintainer, could you please elaborate on what the logic was behind it?
> It does look odd to me to put config files into an arch-dependent
> directory, but I've been out of packaging for close to a decade at this
> point.

I am not a Fedora maintainer, and an arch-dependent triplet
subdirectory is exactly the problem that this patch is fixing.

