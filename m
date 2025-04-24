Return-Path: <netdev+bounces-185639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E7EA9B304
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EC89A446F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6D127F759;
	Thu, 24 Apr 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+wB8mC5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F9B27C879;
	Thu, 24 Apr 2025 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509872; cv=none; b=tQXdn/hAJoCfrCBSrvaVzKc4Ix3o7EiUVKHPn3QWxJGWy7iHuSmW+G00JRoF4JnH06eH5aUDEGw3xw0oPcLfy5R1E90WB+fK+Q6d89tmo+iL86PnqiNAOHZGqSOHymtKtAy25B/L0CtpF6de0nOb0CeCqkcSgMU4P0uoqpRfvRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509872; c=relaxed/simple;
	bh=GPftzG91axIqiH7Y0asxvzEnLZZZ1f/DurBVYN1vCzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYCCzZf+mxdA0nA6vnYWY+xKmvQtbxNpRy5tUsD89QBGEWhEv0SUPITd/NRUwmL+upCSNawdh8uaDqIDMY21BCli1JNX86Oaz9ni8nebz1Q08WAYozRRHzkm2kFbXG2RoztBiVRs7w+p3OiZyAeIoB2oKVL9gLbmKi9sOW7qqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+wB8mC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20EDC4CEE3;
	Thu, 24 Apr 2025 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745509871;
	bh=GPftzG91axIqiH7Y0asxvzEnLZZZ1f/DurBVYN1vCzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+wB8mC57lF57B9oxMg2HV9pqJyp1Ms+wJ5b1XecJxAn/qFtOFgFzJKj70UGFwctC
	 wXyW8eF+499HCLgS/U8c6EZkVWzHD+ZvXVBlprWjlK6f24nUCe+/l9Yauz6P0U5whE
	 txwhlTzYBchlXiPNITE8Hv2dQrcCqZB7Yn1jdm2SJJp77rnC2MIuVfnTMMX3tczEdq
	 SQU3njhXnbCM1lFenzBG5oUFF/i090d9mkDHpzpvKQDcbB8iU8rp9n0hYoCiVhmAPS
	 UpNkrIRQpOIvU7NYe8+enRcUk3qXZl2etIWbcgUrcq0ggLHtDwtUYXf4eD+3Fq2IFi
	 Mbkoyl/7kYtYg==
Date: Thu, 24 Apr 2025 16:51:06 +0100
From: Lee Jones <lee@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/8] Add Microchip ZL3073x support (part 1)
Message-ID: <20250424155106.GI8734@google.com>
References: <20250424154722.534284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424154722.534284-1-ivecera@redhat.com>

On Thu, 24 Apr 2025, Ivan Vecera wrote:

> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
> provides DPLL and PTP functionality. This series bring first part
> that adds the common MFD driver that provides an access to the bus
> that can be either I2C or SPI.
> 
> The next part of the series is bringing the DPLL driver that will
> covers DPLL functionality. Another series will bring PTP driver and
> flashing capability via devlink in the MFD driver will follow soon.
> 
> Testing was done by myself and by Prathosh Satish on Microchip EDS2
> development board with ZL30732 DPLL chip connected over I2C bus.
> 
> Patch breakdown
> ===============
> Patch 1 - Common DT schema for DPLL device and pin
> Patch 2 - DT bindings for microchip,zl3073* devices
> Patch 3 - Basic support for I2C, SPI and regmap configuration
> Patch 4 - Devlink device registration and info
> Patch 5 - Helpers for reading and writing register mailboxes

Whoops!  I just this second replied to v3.

This needs moving out to somewhere more appropriate.

Use MFD to allocate and split the resources, then the sub-devices can do
the technical and heavy API stuff.

> Patch 6 - Fetch invariant register values used by DPLL/PTP sub-drivers
> Patch 7 - Clock ID generation for DPLL driver
> Patch 8 - Register/create DPLL device cells

-- 
Lee Jones [李琼斯]

