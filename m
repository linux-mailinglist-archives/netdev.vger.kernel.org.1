Return-Path: <netdev+bounces-45501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BB57DDA19
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 01:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523751C20CAD
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 00:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A527636B;
	Wed,  1 Nov 2023 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="2KOLpL38";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="sep5SPp7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77951627
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 00:36:20 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6B9F3;
	Tue, 31 Oct 2023 17:36:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 7973760173;
	Wed,  1 Nov 2023 01:36:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1698798971; bh=7+OnU03hnEgdpDmnONAOnNrmZzBC/v9M+zILGmMnYVs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2KOLpL38q0G2qKze6WO6dSOZRCb5zHCOkVr5U4Z7OMWkVLUa1hgS6yrNTR/J4zv7v
	 x5LC+ipe7D9riZxgq4WHcQySuTcM9Pwd3CHuhUtUVQnR7VhXU+U/j36wTo3ub2hYAI
	 lsBPhCUsmSh0krJxLkmD7h77pS2W8uyiCHVLmTVBFXYRmdb2XZm0jGB7+Qo2IvjwYS
	 xHY8lyil58e+Dv6qPj718fbxbC6Dx1vMTGCDirpGJv1DXp6nroGBJZqPPCzYSCzzlS
	 uYgIbsaf/P+8Fm+kH+jA4Ywq31DGC60gDZa9RhK/EagIQKp4EIeqzX8mfrWwRJ3uo9
	 oiXG6AwnAUR1A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VO-KPkDgqbXm; Wed,  1 Nov 2023 01:36:08 +0100 (CET)
Received: from [192.168.1.6] (78-2-88-80.adsl.net.t-com.hr [78.2.88.80])
	by domac.alu.hr (Postfix) with ESMTPSA id 139DE60171;
	Wed,  1 Nov 2023 01:36:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1698798968; bh=7+OnU03hnEgdpDmnONAOnNrmZzBC/v9M+zILGmMnYVs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sep5SPp7jEs9UZ+p2yIjxq6FZhm6zz7bhVx2M7FWKIpDBMHktoFo35jLkJMFSeP9+
	 XBiefuRdHgBdQLSQ4F9r3a4ZfxGmo/9c0CAtOmVSsr28gPIjbdt0Qh7tx+v5N5RQOr
	 FON028Ysh6IgS124y4p4oqNJh4Aw/wNgyM1kgIDkuUvHjHJrocIpaaDGuExxwCU2P/
	 6iniHgAEBN8+jfPx17xH89wEJ4sExbgXtSm0ADNBoy+3UTvDKGKn7AzWEOEG/yYV9i
	 6VTWz7aKge/EXVKkNLbcTmFMvrp547+mLo5j4lvWtKD7wwgcI4dTK0lDzG3UwVHmyI
	 wGeQFORljFG0w==
Message-ID: <4126706e-87f7-40d9-a896-8fc869a0f41d@alu.unizg.hr>
Date: Wed, 1 Nov 2023 01:35:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] r8169: Coalesce r8169_mac_ocp_write/modify calls
 to reduce spinlock stalls
To: Jacob Keller <jacob.e.keller@intel.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <jroedel@suse.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, nic_swsd@realtek.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marco Elver <elver@google.com>
References: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
 <e7a6b0c1-9fc6-480c-a135-7e142514d0e7@intel.com>
 <a85e41ab-7cfa-413a-a446-f1b65c09c9ab@gmail.com>
 <e1c666d8-c7f0-440e-b362-3dbb7a67b242@intel.com>
 <19e2d5fc-7e30-4bb2-943c-f83b44099192@alu.unizg.hr>
 <f2f3a5dc-8b00-400a-9d3f-f10663ce8857@intel.com>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <f2f3a5dc-8b00-400a-9d3f-f10663ce8857@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/23 20:46, Jacob Keller wrote:
> 
> 
> On 10/30/2023 8:51 PM, Mirsad Todorovac wrote:
>> Am I allowed to keep Mr. Keller's Reviewed-by: tags on the reviewed diffs provided
>> that I fix the cover letter issue and objections?
>>
> 
> I have no objections as long as the content otherwise remains the same :)
> 
> Thanks,
> Jake

Of course, one changed character would require another review.

Thank you.

Mirsad

