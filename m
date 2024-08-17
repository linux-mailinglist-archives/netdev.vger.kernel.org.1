Return-Path: <netdev+bounces-119443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0387E9559D8
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 23:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994B1B20FDE
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 21:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B86145A07;
	Sat, 17 Aug 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ErzlH8JN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33712DD88
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723930464; cv=none; b=RTq8BUVWZ3QyQlwvWg0p6hxwpfFAwRUxZ1oPDiPAmh7pT0DdczAAy7ov0Xw2z95cKGwyDIuuLugo0z73L5lrMq42nqoYLJudFrfqoNGMuwAQyXQ5RVTXt62BPdQjeXON5pjK63HRwf1329jdkul/pChfQnD4+kwxl/KCdPvT+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723930464; c=relaxed/simple;
	bh=0UYgIPm2YXVY01BcojqkZIv0c3YHg8Js7c0MB1UcgIQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYdZG8/TzpiqBHeG/CS5C4g7tnA5g+l5Wf+2kaSA5Wx0L/y+ogCcOGrTJIysJYTgEiAGIao28SHYfwDBVVbzZr3ZEqV0TxpWxk8bks58cKTgB6qaakaHNmT4PXmxKLShfxkr6ch/xf3eXsOq0Fy+NQBc+9d4pw1Jp/oeSkFxls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ErzlH8JN; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723930459; x=1724189659;
	bh=CPb7iY9MnNS1T2jgFqtK+We04HUrsHfv3IFGJARoxa8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ErzlH8JNwNrb3rCAhJW98h+6UU56u+6FdNoMFoH5oyDJ0+BcEkED5sMh9AAZvcjxa
	 DH8283jKz3J0tdExzpuehIWkY0ryPtJUnvzjUbok6vJEjggF+xZHV/JHeFxV909LHC
	 053jd1rQqH30eDh7hHFFc5Lf85nddXxA5CzRr8QYur4gYFrC9wkPmG0b0h/WGrvaXS
	 2XPK+3eC0pgOiYka7CgOQjUDRs+xpbLOY8gvMuv5LCjV6hS2OumOrEemc69BHeu1DD
	 VPjZisbg5aofycqsEfIb24MuD2rhqkvMAC785OKPyXV1sX7vSsiwuL6AUASEA+lU4t
	 Vfm+vAnQJPJyg==
Date: Sat, 17 Aug 2024 21:34:13 +0000
To: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 6/6] net: phy: add Applied Micro QT2025 PHY driver
Message-ID: <7f835fe8-e641-4b84-a080-13f4841fb64a@proton.me>
In-Reply-To: <9a7c687a-29a9-4a1a-ad69-39ce7edad371@lunn.ch>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com> <20240817051939.77735-7-fujita.tomonori@gmail.com> <9a7c687a-29a9-4a1a-ad69-39ce7edad371@lunn.ch>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ef0d4e94ed0f65950868f1a1ae0caf34d6ea5def
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.24 20:51, Andrew Lunn wrote:
>> +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
>> +        dev.genphy_read_status::<C45>()
>> +    }
>=20
> Probably a dumb Rust question. Shouldn't this have a ? at the end? It
> can return a negative error code.

`read_status` returns a `Result<u16>` and `Device::genphy_read_status`
also returns a `Result<u16>`. In the function body we just delegate to
the latter, so no `?` is needed. We just return the entire result.

Here is the equivalent pseudo-C code:

    int genphy_read_status(struct phy_device *dev);
   =20
    int read_status(struct phy_device *dev)
    {
        return genphy_read_status(dev);
    }

There you also don't need an if for the negative error code, since it's
just propagated.

Hope this helps!

---
Cheers,
Benno


