Return-Path: <netdev+bounces-227807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AADBB7CB0
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 19:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ADE74E23A4
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E642C2359;
	Fri,  3 Oct 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS/BoVm9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D921EA7C6;
	Fri,  3 Oct 2025 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513415; cv=none; b=RQIJvv1gM+8Kr742cMj+p0HTwzbMVXbXX0I1wgVaoZrpvca4aV8rLpfxioeW5vycYydfEDD0qtrDdDCGLCIfrhTB3PFExlgKU/0KZYs4kyMHRnNy2SrrPWLr4MMfXmsTUTZUK71HWyR2wxn3Rzr8CXbGVMvlpAexdUU7o30l9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513415; c=relaxed/simple;
	bh=MCMm3tLWyqHJADr5NCwVHmqYGQ1hSj7LvI3SVxqxMOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6jlyrZVC3VfX4pTbQnhlE7gC3iU8OefWQtaDsSGbyEcJ+9SLRQP1zZgRj4g268jF4A7pg8nyXETTYvP/JiLrSE0Xz17BMAkBmvbxhn9zRK4LKdeFG/puTmCfaga+yZLNAQlvIZ9in/WfPVj0fIETbpiHxu8R3wTicy2lFGzZAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS/BoVm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941A7C4CEF5;
	Fri,  3 Oct 2025 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759513414;
	bh=MCMm3tLWyqHJADr5NCwVHmqYGQ1hSj7LvI3SVxqxMOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZS/BoVm9DliPZXweZ4XEQ3POm5X2bUHdxHVyYNz4TqA7ZTiAxp664J5f+pudPRYKp
	 LoF81u0f1We+KE+7S/wZP+NxcJcE+DmU3VEJShpXpDeC0D78o2Rs1UJD0Ndhw0WolT
	 iXJnfCUXRJGnnIFCUONgkbFcFG9jgtiQoySQSZfsbJ97enQNVi7RYiZRwO9DSJ7k0V
	 BOgwJz/dBPi2KlimhkKVWEaQOk0V2j1X3mutG8KKVaFVDbK0fUhDkv5p1hw1uSDEz0
	 oXV4PlJp1UEXh0ftb+eEoVBpzmm9vWg14zY0sg+jbD6maBcR0UUWea86UvXe3ZDiAh
	 EXItANEzA5Edw==
Date: Fri, 3 Oct 2025 10:43:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Emil
 Tantilov <emil.s.tantilov@intel.com>, Pavan Kumar Linga
 <pavan.kumar.linga@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, Phani Burra
 <phani.r.burra@intel.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, Anton Nadezhdin
 <anton.nadezhdin@intel.com>, Konstantin Ilichev
 <konstantin.ilichev@intel.com>, Milena Olech <milena.olech@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Joshua Hay
 <joshua.a.hay@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Chittim Madhu <madhu.chittim@intel.com>,
 Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net 3/8] idpf: fix possible race in idpf_vport_stop()
Message-ID: <20251003104332.40581946@kernel.org>
In-Reply-To: <20251001-jk-iwl-net-2025-10-01-v1-3-49fa99e86600@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
	<20251001-jk-iwl-net-2025-10-01-v1-3-49fa99e86600@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 Oct 2025 17:14:13 -0700 Jacob Keller wrote:
> From: Emil Tantilov <emil.s.tantilov@intel.com>
> 
> Make sure to clear the IDPF_VPORT_UP bit on entry. The idpf_vport_stop()
> function is void and once called, the vport teardown is guaranteed to
> happen. Previously the bit was cleared at the end of the function, which
> opened it up to possible races with all instances in the driver where
> operations were conditional on this bit being set. For example, on rmmod
> callbacks in the middle of idpf_vport_stop() end up attempting to remove
> MAC address filter already removed by the function:
> idpf 0000:83:00.0: Received invalid MAC filter payload (op 536) (len 0)

Argh, please stop using the flag based state machines. They CANNOT
replace locking. If there was proper locking in place it wouldn't
have mattered when we clear the flag.

I'm guessing false negatives are okay in how you use the UP flag? 
The commit message doesn't really explain why.

