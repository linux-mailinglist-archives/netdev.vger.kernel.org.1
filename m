Return-Path: <netdev+bounces-208088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C63B09B14
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 08:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A62E1890268
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 06:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E968F1DE891;
	Fri, 18 Jul 2025 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="D56kPnDe"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E617578;
	Fri, 18 Jul 2025 06:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818650; cv=none; b=W3O94l52/afW92h3NCQAKXnBi+8jvf3MhcNs/xbcpdaIMAwUH4iOs0MCdcf9rQ/skscNAjJvvipE0ozjSMtBp1AJl2wvar2fbBAf5SiovRhzMBRAge2oMAl5qD8LqZIbREZelw7h9OnulI+8qJhIXolJh2DsKqBHma6/G/Be7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818650; c=relaxed/simple;
	bh=qNfLc7XonEe7gOviJgyr7hrIJ/hagUUZv3GQNeGmMAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hRHRxOR9sglFho5H+iWuVCgxYK5dhQ7sOOyydXRGdqZLtfmVJ269d9yQ6EhfL3vFWtvtfJNl9ClISK9FCcmUrPHvNTYrD93KxqzHTUh9oJEyJJfeFBPXVAKCCeAtx3/I+Mrzg5/6MiAqksm+Fs2DghKiYe/TIhbsZbb6gbZ3vHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=D56kPnDe; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752818640;
	bh=QuwdC1Tna+trUVMYs7HTIx5JF/YqGy9uHezizJLAtKE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D56kPnDePrW9rZX9tzPGAE2AfDG9S2Ub1u68b5Kjcdvfc1xbGxgmTi2eGy6VllcTp
	 25Pnb2qRTIUP9buFWWCJCjTfl4XAVwNEOcldKWWeqeJy6+1HQWkGXiwBhgid5zPKX1
	 pvJSgGjflIIfFAaRNXA+lpegfsrS0FoXiUFPwNzoh2oH0F8POUtEPKfMBrfwGGZLtq
	 e7vm9i+ni+MNIZJHqV7QoWjQ+9sB27OYVWhVHcq4cHgQ4KpHZ7JB+5gr8GgBhD43Xt
	 UVOC6/eSm0ir/iVJBOtJxH917D8ZoeiNlzX+jFIeKaR6D2qXP0dElKLoTzw/gotfMO
	 I5fwXFaczv2hA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B729C64C1A;
	Fri, 18 Jul 2025 14:03:58 +0800 (AWST)
Message-ID: <59d6a0ee7f47346d8beb0283ee79a493c76dbb45.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>, YH Chung
 <yh_chung@aspeedtech.com>, "matt@codeconstruct.com.au"
 <matt@codeconstruct.com.au>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>,  "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,  "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, BMC-SW
 <BMC-SW@aspeedtech.com>
Cc: Hieu Le <lhieu@os.amperecomputing.com>
Date: Fri, 18 Jul 2025 14:03:58 +0800
In-Reply-To: <5182407d-c252-403a-bb62-ebd11b0f126a@amperemail.onmicrosoft.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
	 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
	 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
	 <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
	 <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
	 <5182407d-c252-403a-bb62-ebd11b0f126a@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Khang,

Thanks for the input, I appreciate it.

> > Khang: any inputs from your side there?
>=20
> I believe segment 0 is a common valid segment and is not reserved.

0 would not have a special meaning in flit mode (ie, when we're using
the segment number); this was more a reference to being optional in
non-flit mode.

> If we want to combine, we might need another bit in the first byte to
> represent if it is flit-mode or not. But I am not sure if it is worth
> the effort, rather than just separate them.

Yep, had the same line of thinking here too.

I agree that it would make sense to have the address format reflect the
actual hardware transport. Having variation across the binding
identifier should not be a problem.

> It should be safer and easier to get the format right for each Physical=
=20
> Medium Identifier, rather than for each Physical Transport Binding.
>
>=20
> So my opinion:
>=20
> - 3-byte for non-Flit (0x08-0x0E medium type)
> =C2=A0=C2=A0 4-byte for Flit Mode (0x40 medium type)
> - Drivers should be able to advertise their Physical Medium Identifier
> =C2=A0=C2=A0 alongside the existing Physical Transport Binding Identifier=
.
> - We can document a stable lladdr / Linux kernel physical format used
> =C2=A0=C2=A0 for sockets for each Physical Medium Identifier, not Physica=
l
> =C2=A0=C2=A0 Transport Binding.

Agreed, sounds like a good plan. I'll look at options for the physical
medium identifier.

YH: so we would just have the three-byte format for your proposed
driver:

   [0]: routing type (bits 0:2, others reserved)
   [1]: bus
   [2]: device / function

- assuming you're only handling non-flit mode for now.

Cheers,


Jeremy

