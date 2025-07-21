Return-Path: <netdev+bounces-208528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24544B0C01F
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33163C0F6B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97B528C84A;
	Mon, 21 Jul 2025 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOMVstTG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC528B4F0;
	Mon, 21 Jul 2025 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089814; cv=none; b=pZOpNOs8l+hKOYYr7ib4usmyhmtnnTWMK+nNL9Y6FQQbcIOikFUpsgpmceY8pNcBhVsiQ1QDJy0HzZZ3bX4p1Kb3X79C/88awDVDqaqch1dtxmKNsB6B4t9qS9OJK+Y4O9yKxSEhB7RMAH9rkH6SsYBFe906ZQ9x3uYLLt73qLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089814; c=relaxed/simple;
	bh=uxjP2gEJbOBmQlv81I1IvKh2j8a6dIhhumYLQw1WC38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm/5OcDF9GJl/zknxE+o6TpHX6hI/EydTuIimK4682wrpL2beR57lSbYspMHpfYos9tmAjOpwXehbOtcSXIg2Mz0t7SkqKyuDyXVoFEFq+POSPKH6co+ZPbwLZxZuaehLQpkYBN3SZBZvnhdxX8VsT1nu8p8LDs8acn6F5yGNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOMVstTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD45C4CEF1;
	Mon, 21 Jul 2025 09:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753089814;
	bh=uxjP2gEJbOBmQlv81I1IvKh2j8a6dIhhumYLQw1WC38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOMVstTGQRd2VVqlltIRirx/UjZsTgs+tGRJ2vk9tPMTNIthsL3LwKRCl2Nzc5gQS
	 NrTF7WBojA/mhex9+9B1H3irU+dS0N6T/Hsj4GjMrd+OMH1CNCbVPMSegQxqTDKiWG
	 Wf/jyUwF46O8oJacFEjy1aj/5y3TCAfTyiaiWfkEqePtk6vrP7e2TzRpFmj3QrJ8KO
	 ISLrGoW1tBPlYRw4MCfyPRB5TJasGkxQD/shwa2ekiT6uZuelmmtimiIDrdEWAdsn5
	 zZKjzFto9RUnrtypGKGECkudk5+Ba+or3Z6h9hrVKhtVleG3svcxI4WsmyktbWWm4k
	 xFJWfSDwX8aDA==
Date: Mon, 21 Jul 2025 11:23:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: dpll: Add clock ID property
Message-ID: <20250721-lean-strong-sponge-7ab0be@kuoka>
References: <20250717171100.2245998-1-ivecera@redhat.com>
 <20250717171100.2245998-2-ivecera@redhat.com>
 <5ff2bb3e-789e-4543-a951-e7f2c0cde80d@kernel.org>
 <6937b833-4f3b-46cc-84a6-d259c5dc842a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6937b833-4f3b-46cc-84a6-d259c5dc842a@redhat.com>

On Fri, Jul 18, 2025 at 02:16:41PM +0200, Ivan Vecera wrote:
> Hi Krzysztof,
> 
> On 18. 07. 25 8:55 dop., Krzysztof Kozlowski wrote:
> > On 17/07/2025 19:10, Ivan Vecera wrote:
> > > Add property to specify the ID of the clock that the DPLL device
> > > drives. The ID value represents Unique Clock Identified (EUI-64)
> > > defined by IEEE 1588 standard.
> > 
> > With the exception of clock-output-names and gpio-hogs, we do not define
> > how the output looks like in the provider bindings.
> > 
> > I also don't understand how this maps to channels and what "device
> > drives a clock" means. Plus how this is not deducible from the compatible...
> 
> The clock-id property name may have been poorly chosen. This ID is used by
> the DPLL subsystem during the registration of a DPLL channel, along with its
> channel ID. A driver that provides DPLL functionality can compute this
> clock-id from any unique chip information, such as a serial number.
> 
> Currently, other drivers that implement DPLL functionality are network
> drivers, and they generate the clock-id from one of their MAC addresses by
> extending it to an EUI-64.
> 
> A standalone DPLL device, like the zl3073x, could use a unique property such
> as its serial number, but the zl3073x does not have one. This patch-set is
> motivated by the need to support such devices by allowing the DPLL device ID
> to be passed via the Device Tree (DT), which is similar to how NICs without
> an assigned MAC address are handled.

You use words like "unique" and MAC, thus I fail to see how one fixed
string for all boards matches this. MACs are unique. Property value set
in DTS for all devices is not.

You also need to explain who assigns this value (MACs are assigned) or
if no one, then why you cannot use random? I also do not see how this
property solves this...  One person would set it to value "1", other to
"2" but third decide to reuse "1"? How do you solve it for all projects
in the upstream?

All this must be clearly explained when you add new, generic property.

Best regards,
Krzysztof


