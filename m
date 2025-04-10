Return-Path: <netdev+bounces-180969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71634A8350E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604E4166A51
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 00:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2104EFC0B;
	Thu, 10 Apr 2025 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaT5Oxgb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D37080E;
	Thu, 10 Apr 2025 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744244235; cv=none; b=qIK6LAONgoX3zLYMcoMJClmem/QxZHNE2nE7WNhRxPVUQviHn7GVU9aL7ktyCEYbJRy+nSEjWIC0YZP4/ySOpIFo2hnofTDBavlc+vPt11Z4yY1xwi30Xwqr0TpDyGs1Wmuk2pSZJamwtkKDmotIfOr2FwmX3+rUfIhCluwC+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744244235; c=relaxed/simple;
	bh=fI41F7Cg84oJdA/p5JmJPu2iEYCdefd/TzI3apBG62o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tq2QcvM6ukdl3hHZASC4C5FgN2mpcVY9yseAhppnlOgYj+On+FwCPTcZ7HikN9He5s+8EXN4cJxbLsFr3gYqlU6FLSbfVU4FTyledWeskv0EizKSmXGv3//reRAfVz7xg2abMcnkZIHKZJ/0YL6n0uPKJrS2Z+cSywEVykQTgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaT5Oxgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B35C4CEE2;
	Thu, 10 Apr 2025 00:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744244234;
	bh=fI41F7Cg84oJdA/p5JmJPu2iEYCdefd/TzI3apBG62o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WaT5OxgbLp2bNuxQPD2pP3tswuVAQUDFPweIacZ0DiRxaxqspJJOQbC8OVHPl8oIh
	 MvKORhRPU0b5iFf4JkOwItDAQj8GdxzemHyPoGKsa0ZixYz2iFXQV6P4u3M48OTunn
	 JRgyfUYp8Xi8DeINnHCGg+tRBH3kXtQt7MRNDUFeJWZaazyLYxJZz4RXdb4sdrhPDi
	 0h8fwOtsgKgsC5sZ6bQ4IUT+Ykmso8TN6Rk/96FvXdJUpk12LzUvejrexolxMmqq5g
	 2yqU7zMXBIWUtffbCWjNGiTT+dHk34bNh4qg1VmrQ1HVE7eF7rDrMShV6QDIn4khlW
	 tMFuI5+VifkzQ==
Date: Wed, 9 Apr 2025 17:17:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, Kees Cook
 <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Add Microchip ZL3073x support (part 1)
Message-ID: <20250409171713.6e9fb666@kernel.org>
In-Reply-To: <20250409144250.206590-1-ivecera@redhat.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Apr 2025 16:42:36 +0200 Ivan Vecera wrote:
> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
> provides DPLL and PTP functionality. This series bring first part
> that adds the common MFD driver that provides an access to the bus
> that can be either I2C or SPI.
> 
> The next series will bring the DPLL driver that will covers DPLL
> functionality. And another ones will bring PTP driver and flashing
> capability via devlink.
> 
> Testing was done by myself and by Prathosh Satish on Microchip EDS2
> development board with ZL30732 DPLL chip connected over I2C bus.

The DPLL here is for timing, right? Not digital logic?
After a brief glance I'm wondering why mfd, PHC + DPLL 
is a pretty common combo. Am I missing something?

