Return-Path: <netdev+bounces-238013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E7C52A4F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F257B34C3DE
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942B2848A1;
	Wed, 12 Nov 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1ZpGPG6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F32D285C84;
	Wed, 12 Nov 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957016; cv=none; b=l+gmHbdadULfwAn+uphglF5gHZFbm5fu+8zVnPb9XD0KqNAPlRK9RUEwnQhL8TnlrhAIBQDWESFFVhDDMm0Zbxsva6vS5M1y4jU4+kaDy+G1I+LB+5WoD7MtFMOUYpIqFjcCsaVnIoa7UqKhDv54/9SRUUsNvxz5ZrAkLECZdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957016; c=relaxed/simple;
	bh=AntEDYQVMQK3hGkf/1USVKSJdPizgJjdmaxygMO5baU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kF8DG3bC81vx8RLYKVsXyMoISET3EY4IC29i3SAJ7IyCXtWvBQMbA8wkbYbXgY1iSEd/P7MfLKj2MY0WIke7sPAE96vYMxxUxMfZa23YD/9L5rCY1kSvd2dGqIYi+m7WB91nD6k2VrW/mWVWcB/ZYYtaLnARXwhdb06PQ4/9XIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1ZpGPG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681C2C113D0;
	Wed, 12 Nov 2025 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762957015;
	bh=AntEDYQVMQK3hGkf/1USVKSJdPizgJjdmaxygMO5baU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l1ZpGPG6Nsys7aydptxdmw86qulWGuTQJTxZvpenymTfLcNCxTdExeJhvdYz8Cbwj
	 iyGCVF/sUFPxwubsxKQaN4TM/lzkpYCqqZWxXQKa4W7WE/KbQUaVfk99V+CWF5f9Va
	 UnK//0yV7bcboG3HsYb3mrLAcasC1WoxNwPtK0QBi9WNS6H9t1i0XFz9jWq8k7Kahh
	 MEOCLPRdb+wWXKbgBZU+fe00yaS5VuU9MxXrDKZffZ/kTvI8eEerpZLdZKoaJg+stW
	 P8dwNxLCrMP7DqmbBHUzxEFeDovvkNQHIyGfwcGZKNgNj3FYAkHQFB9gbp3MGPkxZZ
	 jp0OjlahksV3A==
Date: Wed, 12 Nov 2025 06:16:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpll: zl3073x: fix kernel-doc name and missing
 parameter in fw.c
Message-ID: <20251112061654.2b70e74a@kernel.org>
In-Reply-To: <CAL4kbRPWAfH6AXjsXtwugtpGaH-Omc3uNmtzacFOt1CUqNNWbg@mail.gmail.com>
References: <20251110195030.2248235-1-kriish.sharma2006@gmail.com>
	<20251111174234.53be1a97@kernel.org>
	<CAL4kbRPWAfH6AXjsXtwugtpGaH-Omc3uNmtzacFOt1CUqNNWbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 09:54:32 +0530 Kriish Sharma wrote:
> On Wed, Nov 12, 2025 at 7:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > What do you mean by "documentation build"? make htmldocs? =20
>=20
> Yes, I ran make htmldocs , which triggered the kernel-doc warnings.

Strange, I thought make htmldocs only complains when file in question
is rendered as part of some page. Maybe something changed...

