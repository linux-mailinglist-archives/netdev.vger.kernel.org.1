Return-Path: <netdev+bounces-44204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E0E7D70B6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF141C20A05
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B22AB3C;
	Wed, 25 Oct 2023 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoP9eqNL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD92D62F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 15:25:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF1F1701
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698247514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSOWf+/I8EKI0m+1MG2lTVVX4N7DU8rrjEKjpBfQPhc=;
	b=NoP9eqNLbyR+VX+BFGiu3WgKZiYiEb3ugb58z6Srirp+GJLM+qaEwXLR1g6NHsQsZHx/hm
	Wxvug3UtEUAbjHGbxSKJDA3RB+RUdpyx+YqDWZAdMrvOkKw4+vOzgOm0i3TPs0JFcW4mgK
	Fp0S5LE3geI1rO+5jp1cTF86piE72oo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-M0KvAQokPnukTE8bg2zzOA-1; Wed, 25 Oct 2023 11:25:12 -0400
X-MC-Unique: M0KvAQokPnukTE8bg2zzOA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a62adedadbso363711066b.1
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 08:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698247511; x=1698852311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSOWf+/I8EKI0m+1MG2lTVVX4N7DU8rrjEKjpBfQPhc=;
        b=K3+PcZQ1PtCon4ohS5eyn9J3NjAilGdaW9fQYlgsSCCBNAJlIxSA1f5ZfoLchSqJHB
         ic2W1odYuLRAgUz0DEpiKbgN8CG39Yrz1cbDdLwoO1G0N/aQnzNTA7u0vsvzZlq5Jgas
         liyCwf7igq63MsOulMtZ8A7w+jovgbuoTwo8u3zYUBYX+H1KS8QER2NY1K0lQRvRDCBy
         ebiGm7fTKmSzjvJg02SMz41bJO4SamzlXE5l0Aze/k5Ba2S7Ncci73Nczv4jV+PS+zWX
         R3uTmT/VWXk/JvsXJ5Oe72/x25S69B+LDI3OUFfrsxf2Zfe5GuL034Fj7vuAm5i9+9PC
         rXiA==
X-Gm-Message-State: AOJu0YwKxlDuzw3iAaiISSYpilYnStBDgQhZKmymZbtOx6OLGek/an78
	iS5Gd5oraQZjJArHl5e4KzDhlQNZSXLjDG7TxX2OZBihQDjkTnXp0mTl57oxMdvdNtYgq538Xmf
	YitAJ/idDw81DZoSgOgr/vM3XdrwcLjKj
X-Received: by 2002:a17:907:7215:b0:9bf:b5bc:6c4b with SMTP id dr21-20020a170907721500b009bfb5bc6c4bmr13153733ejc.62.1698247511071;
        Wed, 25 Oct 2023 08:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdPdP4tKmDGqANe1hn/5pBLY9M4r7oTKHQHqnhHAdd00pfX2miKUnEXa1IR6SE8GyZOtoO6reeqBoGcEsfkiE=
X-Received: by 2002:a17:907:7215:b0:9bf:b5bc:6c4b with SMTP id
 dr21-20020a170907721500b009bfb5bc6c4bmr13153717ejc.62.1698247510788; Wed, 25
 Oct 2023 08:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
 <20231023230826.531858-6-jacob.e.keller@intel.com> <20231024164234.46e9bb5f@kernel.org>
In-Reply-To: <20231024164234.46e9bb5f@kernel.org>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 25 Oct 2023 17:24:59 +0200
Message-ID: <CADEbmW0qw1L=Q-nb5+Cnuxm=h4RcdRKWx1Q1TgtiZdEaUWmFeg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/9] iavf: in iavf_down, disable queues when
 removing the driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org, 
	David Miller <davem@davemloft.net>, Wojciech Drewek <wojciech.drewek@intel.com>, 
	Rafal Romanowski <rafal.romanowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 1:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Mon, 23 Oct 2023 16:08:21 -0700 Jacob Keller wrote:
> > From: Michal Schmidt <mschmidt@redhat.com>
> >
> > In iavf_down, we're skipping the scheduling of certain operations if
> > the driver is being removed. However, the IAVF_FLAG_AQ_DISABLE_QUEUES
> > request must not be skipped in this case, because iavf_close waits
> > for the transition to the __IAVF_DOWN state, which happens in
> > iavf_virtchnl_completion after the queues are released.
> >
> > Without this fix, "rmmod iavf" takes half a second per interface that's
> > up and prints the "Device resources not yet released" warning.
> >
> > Fixes: c8de44b577eb ("iavf: do not process adminq tasks when __IAVF_IN_=
REMOVE_TASK is set")
>
> This looks like a 6.6 regression, why send it for net-next?

Hi Jakub,
At first I thought I had a dependency on the preceding patch in the
series, but after rethinking and retesting it, it's actually fine to
put this patch in net.git.
Can you please do that, or will you require resending?

Thanks,
Michal


