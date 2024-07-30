Return-Path: <netdev+bounces-114189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A5294140D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58001F2457B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E991A0AF2;
	Tue, 30 Jul 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wQSUZ8J4"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4FB1A08D0;
	Tue, 30 Jul 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348842; cv=none; b=OmA1NWfjkAVxqaYwwpMhHZ60KGDKWDZQL25+P57rRyX6Skb2b9ZQFApiEBR4iHw/cZwb49bxTnvMy43W+y0uTqMVembM5EsPl48X3jY6C7WrCz3W+zD6T65GTjl0oksJTFIVaOYwZ4SHg37YVLMKyx3K4BXLoO7y4UPDevvLiwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348842; c=relaxed/simple;
	bh=hzJPZk4RgEaN97TJAdr+IGFo947mjdk1g2URqIQg9CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/tqBpEU/2YWGh7KBmUJaNfkn14QqSSW0QFkYeFrv+CJ1wEQ/1c4K+rIz/tPu0Rw1uQXp4xzcFW446SEz+HQpnRos61n8aH9+WeerHI2tIBLbY/wHufkcJmJXLIYn49cq3fj5CCFZPPI/E3thJvgm+Rt6lAxJ/9nHCadaLhzETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wQSUZ8J4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Wyglv7opTBeCJkn4W8ORKK2LcvPN5HM2lHPGpHhGR4U=; b=wQSUZ8J4kUX9rNh8zaejaJonbI
	SdyT6hKLbdAZxBWuRdz2WeDpamiNxnRe4xp1BsKtBJQOYZx7aqI6sBpoBYJsFD2rbROmKsLzL8ZPK
	eDm7ZHOGE66gLYI+ZV0d39CCzoD2FSoO8S2DAZNJymcRboUWyX6cmkS8GdEsTnj52whLxiSq89a09
	Smf13ylEnDjKw2lYw4ITW0HBFdMzMO2ayKKxpKEhpcoL7cPgIbfpzNXzSU6cqfNQJ7GIWl1bED/S2
	I9H8usp7FX66jERzpZsyANE1M8fr2Br5odHfMqP6breXaneFEbEbm2FBfQ/RPmQjyblJzXs12OjvB
	tVVCDIcA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnbv-0000000FPEs-3nsb;
	Tue, 30 Jul 2024 14:13:55 +0000
Message-ID: <190e49bb-88d2-49fe-a228-c379c33503c1@infradead.org>
Date: Tue, 30 Jul 2024 07:13:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/24] docs: geniezone: Introduce GenieZone hypervisor
To: Liju-clr Chen <liju-clr.chen@mediatek.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yingshiuan Pan <Yingshiuan.Pan@mediatek.com>,
 Ze-yu Wang <Ze-yu.Wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Shawn Hsiao <shawn.hsiao@mediatek.com>,
 PeiLun Suei <PeiLun.Suei@mediatek.com>,
 Chi-shen Yeh <Chi-shen.Yeh@mediatek.com>,
 Kevenny Hsieh <Kevenny.Hsieh@mediatek.com>
References: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
 <20240730082436.9151-3-liju-clr.chen@mediatek.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240730082436.9151-3-liju-clr.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 7/30/24 1:24 AM, Liju-clr Chen wrote:
> From: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> 
> GenieZone is MediaTek proprietary hypervisor solution, and it is running
> in EL2 stand alone as a type-I hypervisor. It is a pure EL2
> implementation which implies it does not rely any specific host VM, and
> this behavior improves GenieZone's security as it limits its interface.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Co-developed-by: Yi-De Wu <yi-de.wu@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> ---
>  Documentation/virt/geniezone/introduction.rst | 87 +++++++++++++++++++
>  Documentation/virt/index.rst                  |  1 +
>  MAINTAINERS                                   |  6 ++
>  3 files changed, 94 insertions(+)
>  create mode 100644 Documentation/virt/geniezone/introduction.rst
> 
> diff --git a/Documentation/virt/geniezone/introduction.rst b/Documentation/virt/geniezone/introduction.rst
> new file mode 100644
> index 000000000000..f280476228b3
> --- /dev/null
> +++ b/Documentation/virt/geniezone/introduction.rst
> @@ -0,0 +1,87 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================
> +GenieZone Introduction
> +======================
> +
> +Overview
> +========
> +GenieZone hypervisor (gzvm) is a type-1 hypervisor that supports various virtual
> +machine types and provides security features such as TEE-like scenarios and
> +secure boot. It can create guest VMs for security use cases and has
> +virtualization capabilities for both platform and interrupt. Although the
> +hypervisor can be booted independently, it requires the assistance of GenieZone
> +hypervisor kernel driver(also named gzvm) to leverage the ability of Linux

                     driver (also

> +kernel for vCPU scheduling, memory management, inter-VM communication and virtio
> +backend support.
> +
> +Supported Architecture
> +======================
> +GenieZone now only supports MediaTek ARM64 SoC.
> +
> +Features
> +========
> +
> +- vCPU Management
> +
> +  VM manager aims to provide vCPUs on the basis of time sharing on physical
> +  CPUs. It requires Linux kernel in host VM for vCPU scheduling and VM power
> +  management.
> +
> +- Memory Management
> +
> +  Direct use of physical memory from VMs is forbidden and designed to be
> +  dictated to the privilege models managed by GenieZone hypervisor for security
> +  reason. With the help of gzvm module, the hypervisor would be able to manipulate

Is this change acceptable?:

             With the help of the gzvm module, the hypervisor is able to manipulate

> +  memory as objects.
> +
> +- Virtual Platform
> +
> +  We manage to emulate a virtual mobile platform for guest OS running on guest

     s/We manage to emulate/The gzvm hypervisor emulates/

or something like that...

> +  VM. The platform supports various architecture-defined devices, such as
> +  virtual arch timer, GIC, MMIO, PSCI, and exception watching...etc.
> +
> +- Inter-VM Communication
> +
> +  Communication among guest VMs was provided mainly on RPC. More communication

                                   is provided

> +  mechanisms were to be provided in the future based on VirtIO-vsock.

                are to be provided
or
                will be provided

> +
> +- Device Virtualization
> +
> +  The solution is provided using the well-known VirtIO. The gzvm module would

                                                           The gzvm module

> +  redirect MMIO traps back to VMM where the virtual devices are mostly emulated.

     redirects

> +  Ioeventfd is implemented using eventfd for signaling host VM that some IO
> +  events in guest VMs need to be processed.
> +
> +- Interrupt virtualization
> +
> +  All Interrupts during some guest VMs running would be handled by GenieZone

         interrupts                               are handled

> +  hypervisor with the help of gzvm module, both virtual and physical ones.
> +  In case there's no guest VM running out there, physical interrupts would be

                     no guest VM running, physical interrupts are

> +  handled by host VM directly for performance reason. Irqfd is also implemented
> +  using eventfd for accepting vIRQ requests in gzvm module.
> +
> +Platform architecture component
> +===============================
> +
> +- vm
> +
> +  The vm component is responsible for setting up the capability and memory
> +  management for the protected VMs. The capability is mainly about the lifecycle
> +  control and boot context initialization. And the memory management is highly
> +  integrated with ARM 2-stage translation tables to convert VA to IPA to PA
> +  under proper security measures required by protected VMs.
> +
> +- vcpu
> +
> +  The vcpu component is the core of virtualizing aarch64 physical CPU runnable,

The ending "runnable" doesn't seem to fit here - or I just can't parse that.

> +  and it controls the vCPU lifecycle including creating, running and destroying.
> +  With self-defined exit handler, the vm component would be able to act

                                     the vm component is able to act

> +  accordingly before terminated.

                 before termination.
or
                 before being terminated.
or
                 before exit.

> +
> +- vgic
> +
> +  The vgic component exposes control interfaces to Linux kernel via irqchip, and
> +  we intend to support all SPI, PPI, and SGI. When it comes to virtual
> +  interrupts, the GenieZone hypervisor would write to list registers and trigger

                               hypervisor writes to list registers and triggers

> +  vIRQ injection in guest VMs via GIC.


HTH.
-- 
~Randy

