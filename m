Return-Path: <netdev+bounces-132912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9AF993B74
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6328284177
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE91192592;
	Mon,  7 Oct 2024 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS4lWkvM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D2184551;
	Mon,  7 Oct 2024 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345373; cv=none; b=XfFPhRKctPxIGJIjgktgicVM9QczgAF7izQL80Opz/5fI4EPmg03TkyynEpr2sGWJ4+NDuS0VL1De4nwU9GkQtwGLeal5nqhvd+Rfhz9D79jYoCqNR0NqV5+V2rkslnkM3iowFGm0EWZurvc6L0Hv9t/tC5jgHT/fdTg0Fv1n4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345373; c=relaxed/simple;
	bh=NaPOh5BUWSB6d2KsKXk23qDmtde+/k4RK5GNndavIsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQP2sN21JeP1XjqXGRTT1HSdVAqi6EzLrbrdvJRiUvYRDSL3WVx2jZjAC7Q1HVwLKciAs+W3lDyHKGEgzLgBQOoUY08n+q/D9beoNd7wwxKOKVmtiavju4wk0di+p72KZWb4mCi+IziSDYs5thklC7/hbGi8/cXSHROHM0pMLwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS4lWkvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B214C4CECD;
	Mon,  7 Oct 2024 23:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728345372;
	bh=NaPOh5BUWSB6d2KsKXk23qDmtde+/k4RK5GNndavIsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mS4lWkvMkoIzT+YIChHb/yxkcrEWqZDx240PkWx9sG4SJufKkZ2aTc24VuOga42aK
	 kQqSGTXiE3NOoSXI8oUqKLG6ytyBpKggcKsUOhWgwd3SPZy+5l8ouibvjjDfjTLU8x
	 HDzY1mMYwtuR5/VBL9c+gzHW5L12qm7ClTIMkDOqCnZ+Ocadmp+BcBQ6lhplyrO5Ad
	 6PuoUVP5LrufaV2eekxYZlWP5Qntyjj5EqWPrXYhT5ixqCxPPsURuGsfHk9WHjsbR2
	 VQquQ01ikEuLwmEQyDdegw8ZV4W5pJvqMzvUzek63iizgpq2mKe/to/tN7Ur9Ma9lW
	 WNSYSV7TDZXXg==
Date: Mon, 7 Oct 2024 16:56:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Sanman Pradhan <sanman.p211993@gmail.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, kernel-team@meta.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jdelvare@suse.com,
 linux@roeck-us.net, horms@kernel.org, mohsin.bashr@gmail.com,
 sanmanpradhan@meta.com, andrew@lunn.ch, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next v3] eth: fbnic: Add hardware monitoring support
 via HWMON interface
Message-ID: <20241007165611.3ee5bc73@kernel.org>
In-Reply-To: <CAH-L+nO6U12TRCUWNxjAFTSwaMfeadt+iHYtYFZHVJFOZH0sdw@mail.gmail.com>
References: <20241004204953.2223536-1-sanman.p211993@gmail.com>
	<CAH-L+nO6U12TRCUWNxjAFTSwaMfeadt+iHYtYFZHVJFOZH0sdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Oct 2024 09:53:30 +0530 Kalesh Anakkur Purayil wrote:
> [Kalesh] You should change this label to "hwmon_unregister" as you
> should unregister hwmon in case of failure here.

Not really, but you're right that there's a problem with the error path
here..

> > @@ -297,7 +299,7 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >         netdev = fbnic_netdev_alloc(fbd);
> >         if (!netdev) {
> >                 dev_err(&pdev->dev, "Netdev allocation failed\n");
> > -               goto init_failure_mode;
> > +               goto hwmon_unregister;
> >         }


.. I don't think we should unregister HWMON if netdev alloc fails.
We will enter "init failure mode" (IFM), and leave the driver bound.
HWMON interface can remain registered, just like devlink and other
auxiliary interfaces.
-- 
pw-bot: cr

