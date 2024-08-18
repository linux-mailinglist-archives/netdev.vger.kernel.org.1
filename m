Return-Path: <netdev+bounces-119483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E58955D50
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BF01C20936
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FAC129E9C;
	Sun, 18 Aug 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TsOhmjhU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C1112B8B;
	Sun, 18 Aug 2024 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723996490; cv=none; b=oTBNwf8Ku9HFdv1dCkOVMVWuLSZst+iaRwcu3uJRZbWzFE5B4v66z5btIE3qpEaLcCK5y2ajrJla1FtnybDh5m1apCjeHvwbqdZ4WF/fFiSCiYXgCkGYtjffmAsexnCPMFJLO5TaNF7kDdPpjjTHRIDrWhgw24OSHrI06NylvYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723996490; c=relaxed/simple;
	bh=JIavcdyIftalpfiaiyE1P8m/1QVzJn4AFx9izfMyY70=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HirUAbLpn9P6PZmpuph1lAvpXMqyl8K07hW++0P4PqSj/a90XEzlD5DPnZ5mAi5RF2RlVXChdfe9eAzz5+Xc6vJI7nJ4yDS2LXTv2sNR9jTyh+ohyj7KLg8jHTGAR+jdLAP0BQMjHRzCVFpIPbWUfbZ77h/D5QW4qRUGCeqQFK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TsOhmjhU; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xvciuy6z4bh4bi7t5cnbz7jdby.protonmail; t=1723996485; x=1724255685;
	bh=Va996Zz9XhF82uqmTyDqYR4Ub4pHzIhxUq/ONfADyNU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TsOhmjhUe2G7SSVnllqgEmfmRSVgncLTLk5/I8cRjQb4PxayfF1B0Pyq3q1kuQJT0
	 M2QngeFq6Myxb/FWoMxKSnCDSMFH2OsHhj/xzYn+Re7tBJsbPCh1s8oqmnXRbiGLvj
	 Ok6VWGNvo/xm3HfdnvdZFQOS/abixNy9XarXexi6/Ytg61H8Hkg4G38y7AuJSlg+w/
	 gmQN/rrmW/kkZXpNDwjNrpDiMR37RfKIERQxGskRwJbZwVaYdIY6FcI6nWRnkGtSFJ
	 6uORW6LPztSZplouS/j5kSxni2zbWOXiraZnt4wyMUKJs6znYq61QfBLEyDBxSomKl
	 mHag258GTIUeQ==
Date: Sun, 18 Aug 2024 15:54:40 +0000
To: Greg KH <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
Message-ID: <fa0534e5-a4e9-45e5-a202-e4647c99c514@proton.me>
In-Reply-To: <2024081809-scoff-uncross-5061@gregkh>
References: <a8284afb-d01f-47c7-835f-49097708a53e@proton.me> <20240818.021341.1481957326827323675.fujita.tomonori@gmail.com> <9127c46d-688c-41ea-8f6c-2ca6bdcdd2cd@proton.me> <20240818.073603.398833722324231598.fujita.tomonori@gmail.com> <f480eb03-78f5-497e-a71d-57ba4f596153@proton.me> <1afb6d69-f850-455f-97e2-361d490a2637@lunn.ch> <2024081809-scoff-uncross-5061@gregkh>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 51d8cb1606cdc7c46a8ec1d91188f561a9d0de87
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.08.24 17:45, Greg KH wrote:
> On Sun, Aug 18, 2024 at 05:38:01PM +0200, Andrew Lunn wrote:
>>> Just to be sure: the `phydev.mdio.dev` struct is refcounted and
>>> incrementing the refcount is fine, right?
>>
>> There is nothing special here. PHY devices are just normal Linux
>> devices. The device core is responsible for calling .probe() and
>> .remove() on a device, and these should be the first and last
>> operation on a device. The device core provides refcounting of the
>> struct device, so it should always be valid.

Thanks that's good to know.

>> So i have to wounder if you are solving this at the correct
>> level. This should be generic to any device, so the Rust concept of a
>> device should be stating these guarantees, not each specific type of
>> device.
>=20
> It should, why isn't it using the rust binding to Device that we already
> have:
> =09https://rust.docs.kernel.org/kernel/device/struct.Device.html
> or is it?  I'm confused now...

It is using that one.
I wanted to verify that we can use that one, since using this
implementation users can freely increment the refcount of the device
(without decrementing it before control is given back to PHYLIB). Since
that seems to be the case, all is fine.

---
Cheers,
Benno


