Return-Path: <netdev+bounces-196814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BF8AD6794
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A87164750
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 06:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E721153598;
	Thu, 12 Jun 2025 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMKm5pAY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872119A
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708163; cv=none; b=siUljY0HyCmSuMFJopwV4l35iLStJxKTE+PpK/6DRWmhoWIR49wnlBDLEX+kLV5xl3yhJDFd8+LXz82EJEurtQ7fcGAgtO0G+ZnoW8HxoDpyOFXk8idBG6Izj1sHL3dp5dG1qARfIaXZNBmbG4zAlFTS9PjywYK6J+SgX63F0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708163; c=relaxed/simple;
	bh=lwxZ3NbzX6cpFg1C1iCADDK5gDIK+ZgoTzESgyRy1A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaW25JrxnqSM1JY02SoGO8yYaSJ8XGS+od2WV5GVnXrqL83ZeVgrSFM1J7fGeFyz7MWogbw0o8HWDDsUvmZt+1k/BlbgJ+IZ/gTeTH4benX9ibqm7AOeco1O6iD7BVL5VExBhvgl2B8x3jXKPLnzJgewAVjMF10EB7rZei3feyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMKm5pAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A397FC4CEEA;
	Thu, 12 Jun 2025 06:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749708161;
	bh=lwxZ3NbzX6cpFg1C1iCADDK5gDIK+ZgoTzESgyRy1A0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PMKm5pAYSKqxdG1Rv9Hnwo2JQORCQHZR5fLOtGVEmjjIJGsiR/8y5lWIg5yWGG0JE
	 DGIpdjbWW6cgdwHQ3jhCjDA3yUjVQnGFYc/ccGchKrT5T+zSo9DXXnelMeAQvzEzlo
	 92H44z8PqIpTONNETH2LT/YVoNOT2E6g/3Qq7eI9bilffBcRw0IpEjfmijTGdNCByu
	 oXb/kxTy0Rs85WLPMXbmzirmosLH/qa8TZpClT69CmTSq5lxgyNJDuD+4fmyF7Xvsw
	 xS3pcVkZlCTHjhd+gAh9ENME18dsWyZeRkeGaQREtSlMRZLOowe9snfzhJsrP4ix0+
	 /dMEB92EkIa1w==
Message-ID: <b3d13533-45bd-4504-aa02-82c88b047033@kernel.org>
Date: Thu, 12 Jun 2025 08:02:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Add new iccnet driver
To: Khalid Mughal <khalid.mughal@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Sridhar Samudrala <sridhar.samudrala@intel.com>
References: <20250611155402.1260634-1-khalid.mughal@intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250611155402.1260634-1-khalid.mughal@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2025 17:54, Khalid Mughal wrote:
> Intel(R) IPU ICCNET (Inter-Complex Communication Network) Driver:
> 
> The iccnet (Inter-Core Communication Network) driver enables sideband
> channel communication between the Management-Complex and the
> Compute-Complex, both powered by ARMv8 CPUs, on the Intel IPU
> (Infrastructure Processing Unit). The driver establishes descriptor
> rings for transmission and reception using a shared memory region
> accessible to both CPU complexes. The TX ring of one CPU maps
> directly to the RX ring of the other CPU.
> 
> == Initial and Evolving Use Cases ==
> 
> The initial use case was limited to simple utilities like scp, ssh,
> etc. However, iccnet evolved into the primary communication channel
> for iSCSI. In this scenario, Compute-Complex requires iSCSI to boot
> its OS, with the Management-Complex acting as an iSCSI server
> utilizing its SSD/NVMe storage. As a result, iccnet is now the
> default communication interface between Management-Complex and
> Compute-Complex for iSCSI. Since iSCSI relies on TCP/IP, a proper
> netdev driver is required.
> 
> == Driver Design ==
> 
> The iccnet is implemented as a generic netdev driver, enabling
> seamless integration with the Linux TCP/IP stack, without requiring
> custom socket APIs. The driver uses ARPHRD_RAWIP, forming a
> point-to-point link between Management-Complex and Compute-Complex.
> 
> It uses a reserved 2MB section of shared memory (outside the OS
> domains of Management-Complex and Compute-Complex), within a larger
> shared memory region. The driver follows a simple descriptor ring
> model. Each descriptor includes a status word with an ownership bit
> and a buffer for packet/frame data.
> On transmit:
>   Data is copied via memcpy() (no DMA available),
>   The ownership bit is set, and
>   An interrupt is triggered to notify the peer.
> On receive:
>   The interrupt handler processes the packet,
>   Copies the data via memcpy(), and
>   Resets the ownership bit.
> 
> Since the iccnet driver does not include an Ethernet header and lacks
> ARP support, a static route must be added after module insertion, e.g.
>     On Compute-Complex: ip route add 10.0.0.1 dev iccnet
>     On Management-Complex: ip route add 10.0.0.2 dev iccnet
> 
> == Alternative Solutions Considered ==
> 
> Before developing iccnet, several existing solutions were evaluated,
> but none met the requirements:
> 1. virtio-net: Requires a backend device model between CPU complexes.
> 2. veth (Virtual Ethernet): Only works within the same Linux network
>    namespace and does not support shared memory communication.
> 3. PRMsg (Remote Processor Messaging): Cannot expose a netdev
>    interface, which is required for iSCSI.
> 4. Mailbox Framework: Similar to RPMsg; lacks netdev support,
>    making it unsuitable for iSCSI.
> 
> Signed-off-by: Khalid Mughal <khalid.mughal@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
> v2:
> - Fixed issues highlighted by Marcin Szycik
> v3:
> - Fixed internal-kbuild-all build warning
> v4:
> - Changed iccnet header padding
> ---
>  .../devicetree/bindings/net/intel,iccnet.yaml |  71 +++

That's a separate patch.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time.

Please kindly resend and include all necessary To/Cc entries.
</form letter>

Best regards,
Krzysztof

