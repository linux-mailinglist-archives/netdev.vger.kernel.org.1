Return-Path: <netdev+bounces-208036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B2B09845
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB0F189A522
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7232424469E;
	Thu, 17 Jul 2025 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdLl34r+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CBE244663;
	Thu, 17 Jul 2025 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795644; cv=none; b=j0Ke+msGihRSGrsYPmskkq3cxSAG1ac6TvskDVboRx79vK9wE81Hl2fKq2jYL4gp4jLyRdE0lLhYL9PLd6WulLhPcyVwjErTZGPhoXBPAiwldUUoHMFU3Gflv1BIQ/8I6b0O8O9p5yBi/eSt5TUGK7d0AbfP0gX69+RpojDtqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795644; c=relaxed/simple;
	bh=ghBY1u06RQVl7caGRzm3Kqd91PsHNCfEneyju2vTcIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUCKmSAU0W555P1S/aHn42BRBaO62gWEGW9iZjh4nJNvDKuoBGscjkPXqYBxAx9/l03QgaXCbaFlQdt8mVRJW7DN4bEAUmyniBfwmbDKepALBWFYmmMeJafe69CfhLNitHAWaDRcBSDuMqQyJxLD+vyeRR0gIfoMYx6+NyDsizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdLl34r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3429C4CEE3;
	Thu, 17 Jul 2025 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795644;
	bh=ghBY1u06RQVl7caGRzm3Kqd91PsHNCfEneyju2vTcIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UdLl34r+HqmNKqWBlkKD1rEBbNQo8dTKaB2cDs3pjy7GoC7tvjxuNI08s91vqC3jy
	 3muBFKYDArqYVpTO7NwuFpoeSLiZMhYKZ6m0tYtvNmAknUQprv7fGSQmulYKbdVJDj
	 SyyD9uKEwXibjrJOszDDiNOmKuGDf3vaqNmOe9Mvb+L3FrLgcLC/QK9Hnpb/0HzfS4
	 ar0PRWxwtVKFgwFdNcEILDKlgapYnkd9nZOVYdJihPJZkutFOSpXWDh0OW8y683kkL
	 OxTtJ7pagF0Hj4t4H30Tosq3G9mG8FXZnFyG0ImUfxCDlaitqDhrFA31bSeCrQZ4ME
	 SWU0lipl3oi3g==
Date: Thu, 17 Jul 2025 16:40:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
 <corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
 <fuguiming@h-partners.com>, <gongfan1@huawei.com>, <guoxin09@huawei.com>,
 <helgaas@kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
 <lee@trager.us>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
 <meny.yossefi@huawei.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
 <shenchenyang1@hisilicon.com>, <shijing34@huawei.com>,
 <sumang@marvell.com>, <vadim.fedorenko@linux.dev>, <wulike1@huawei.com>,
 <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v09 1/8] hinic3: Async Event Queue interfaces
Message-ID: <20250717164042.6802a18b@kernel.org>
In-Reply-To: <20250717080229.1054761-1-gur.stavi@huawei.com>
References: <20250716183208.26b87aa8@kernel.org>
	<20250717080229.1054761-1-gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 11:02:29 +0300 Gur Stavi wrote:
> On Tue, 15 Jul 2025 08:28:36 +0800 Fan Gong wrote:
> > +/* Data provided to/by cmdq is arranged in structs with little endian fields but
> > + * every dword (32bits) should be swapped since HW swaps it again when it
> > + * copies it from/to host memory. This is a mandatory swap regardless of the
> > + * CPU endianness.  
> 
> > This comment makes no sense, FWIW. The device writes a byte steam
> > to host memory. For what you're saying to make sense the device would
> > have to intentionally switch the endian based on the host CPU.
> > And if it could do that why wouldn't it do it in the opposite
> > direction, avoiding the swap ? :/
> >
> > I suppose the device is always writing in be32 words, and you should
> > be converting from be32.
> >  
> 
> Lets assume the following is a simplified PACKED cmdq struct:
> 
> struct some_cmdq {
> 	__le16 a;
> 	__le32 b;
> 	__le16 c;
> };
> 
> Lets denote x0 as lsb of field x. x3 as msb of 32 bits field.
> 
> Byte stream in CPU memory is:
> a0, a1, b0, b1, b2, b3, c0, c1
> 
> The HW expects the following byte stream:
> b1, b0, a1, a0, c1, c0, b3 ,b2
> 
> A native struct would be:
> 
> struct some_cmdq {
> 	__be16 b_lo;
> 	__be16 a;
> 	__be16 c;
> 	__be16 b_hi;
> }
> 
> It does not make sense from code readability perspective.
> While this is a simplified example, there are similar problems in real cmdq
> structs.
> Also group of fields that makes sense (based on their names) for being
> logically near each other become separated in "native" big endian arrangements.
> 
> This is a case where driver need to compensate for bad HW decisions.

My point was just that the calculation does not survive change of
endian on the host. You given an example of the host struct being
in LE and then the swap working out. But IIRC the driver does not
use LE for its view of the fields. So the host view of the struct
is:

struct some_cmdq {
 	u16 a;
 	u32 b;
 	u16 c;
};

The comment saying that the swap is "regardless of host endianness"
is just confusion on the part of the author :/

