Return-Path: <netdev+bounces-185865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD54A9BEFE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303B7175444
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 06:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B6D22D4DF;
	Fri, 25 Apr 2025 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB1rwWlA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3DA4414;
	Fri, 25 Apr 2025 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564165; cv=none; b=DNMimLg5WQ33NuIHPq/X4DbrlPYcal0B6uNkeKX3RtO2iafhi/galOSobvcXgMR7t7QOH4EZGrRQwwoZmGBAC7+RTQ+elWgVBQdzu4SNfs0V2diA9aj+woB5vgMXlH6utKiq52/s42+dMff55JK/rJJSUDICoGGGl1b7Q7P7rFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564165; c=relaxed/simple;
	bh=0yMbrLX7O4xZy7JYu0z5l/mJew7X+c/RPL7m/h67+3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP1yVKTAkVtBFmOntAR+IR8/ehIlpBrtckkcNvhXEK+rV0MR8XrM2/i7+vNYcl9SzJexlxJcx5kbgXuDZunHyJ/2geVbElushpThKIeKyo+TXK/tw0u2hdjIMf33jH73QEDzLGrO4/bkHKZ7MNH99jGfayVI9ddTbVTT7vdnQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB1rwWlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1C2C4CEE4;
	Fri, 25 Apr 2025 06:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745564165;
	bh=0yMbrLX7O4xZy7JYu0z5l/mJew7X+c/RPL7m/h67+3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oB1rwWlAYkRfWFnSUeniG98t1ZNHKhANdU5tWLR++w0N7tDsH2zejPUqknuQHm1GU
	 53bDPeZq8nrmjaQ5+0rbVyUQ/jH9n8WwerpKwyhmMNlGrJaU2h7aaWmESGFpjxAXKL
	 LZozyV+3fFu42BTmYI+DglTYB6RAQTXzX/+V/S8NBd89Csrk5nzvO4xlY0upzCR6Wy
	 qcaLQmxEpW02qMJqbPJIgCR4C4dXYgOxy4UkkpcFRC79uSOYBTRPB09fYfxTIh1BeJ
	 IyeStti+91b6ZOpn/IL1JEio/JMMJ6m4oRO+9osoDwuZViljcKdopljWAHWn4c1Tbj
	 9DcgVzUF8UTdw==
Date: Fri, 25 Apr 2025 07:55:58 +0100
From: Lee Jones <lee@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <20250425065558.GP8734@google.com>
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-6-ivecera@redhat.com>
 <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
 <bd645425-b9cb-454d-8971-646501704697@redhat.com>
 <d36c34f8-f67a-40ac-a317-3b4e717724ce@lunn.ch>
 <458254c7-da05-4b27-870d-08458eb89ba6@redhat.com>
 <98ae9365-423c-4c7e-8b76-dcea3762ce79@lunn.ch>
 <7d96b3a4-9098-4ffa-be51-4ce5dd64a112@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d96b3a4-9098-4ffa-be51-4ce5dd64a112@redhat.com>

On Thu, 24 Apr 2025, Ivan Vecera wrote:

> 
> 
> On 24. 04. 25 9:29 odp., Andrew Lunn wrote:
> > > Yes, PHC (PTP) sub-driver is using mailboxes as well. Gpio as well for some
> > > initial configuration.
> > 
> > O.K, so the mailbox code needs sharing. The question is, where do you
> > put it.
> 
> This is crucial question... If I put the MB API into DPLL sub-driver
> then PTP sub-driver will depend on it. Potential GPIO sub-driver as
> well.
> 
> There could be some special library module to provide this for
> sub-drivers but is this what we want? And if so where to put it?

MFD is designed to take potentially large, monolithic devices and split
them up into smaller, more organised chunks, then Linusify them.  This
way, area experts (subsystem maintainers) get to concern themselves only
with the remit to which they are most specialised / knowledgable.  MFD
will handle how each of these areas are divided up and create all of the
shared resources for them.  On the odd occasion it will also provide a
_small_ API that the children can use to talk to the parent device.

However .... some devices, like yours, demand an API which is too
complex to reside in the MFD subsystem itself.  This is not the first
time this has happened and I doubt it will be the last.  My first
recommendation is usually to place all of the comms in drivers/platform,
since, at least in my own mind, if a complex API is required, then the
device has become almost platform-like.  There are lots of examples of
H/W comm APIs in there already for you to peruse.

-- 
Lee Jones [李琼斯]

