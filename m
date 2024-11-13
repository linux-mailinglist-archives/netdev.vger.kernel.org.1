Return-Path: <netdev+bounces-144507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BF69C7A2A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8F21F2354C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A81537C8;
	Wed, 13 Nov 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="YDmPfawC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538802AD04;
	Wed, 13 Nov 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519937; cv=none; b=nBVR6sDNlNB7FV7tfOqB97Vyr7KJMMbf+OLsPs07gyar/AOsSIV3Ah4HTgEhS/qZ1AkutQKPDPruF2HuCX6UO2WbIl1PknkDQLL3G7ta6uF3TeTGg8h8ZX9qTBQPDLwHjh0BXmGJsBa/R/dpvVu4hjrdbw9+ZsBIK+vluy2S0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519937; c=relaxed/simple;
	bh=ouU8nt3JsXlK78zj5uuwL+vjo5Uce23CbeGxmbr8B9U=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kVeEkShVuYBrgrm1F9XXkBnT3dbnK+uZpvel+FCLHvr8mAn4XB/b9uc1CuvbG/uP+78uTBlBV+0LvkvjMSGFjy9UG3SPbjth8BBp2+lr85zQ2Y+/Rrt3zpuiC4+76FWQZ79UeETbmlffEXSImhqAwlXrUOhXUd9CuULDKJWhBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=YDmPfawC; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1731519928; x=1731779128;
	bh=qDkledNX1dxRvLVNlPVfDD+QPBH5mY67kbum7HJWB1Q=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=YDmPfawCaoWGBXmqGK5KGNw/r5lK9U5otzQE1fRqahIxUf+POVqG4f39EkE4jxyK/
	 oTZVwxTmOUwKSNZXyI+smlrwqPefcxxxZvhItphUUgPgTJAd2C649ZBeWBE/M/D7sb
	 QJrVmIZNB3nU5sQbwekBA7FPhRzWkbl54SfnFK7N08ee3RnJEVq5S+07XyJ0A3zTNX
	 MsnLGn/+IARfE+/ptCZr29KFp+kEf9zF/RY6WEVgP1J1pAxvQX6dJHxpjj47dvswyM
	 antIUwLS+ZvgopIhBaYnRt25hN3nmP8ux+isSXPbrv8xeiq13n6a+1EkPTKleIJh/v
	 ds2ysnSY+1Enw==
Date: Wed, 13 Nov 2024 17:45:22 +0000
To: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH net] rust: net::phy scope ThisModule usage in the module_phy_driver macro
Message-ID: <20241113174438.327414-3-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 991b5249b217713fec86a807ffc22bea6c61dfff
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Similar to the use of $crate::Module, ThisModule should be referred to as
$crate::ThisModule in the macro evaluation. The reason the macro previously
did not cause any errors is because all the users of the macro would use
kernel::prelude::*, bringing ThisModule into scope.

Fixes: 2fe11d5ab35d ("rust: net::phy add module_phy_driver macro")
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---

Notes:
    How I came up with this change:
   =20
    I was working on my own rust bindings and rust driver when I compared m=
y
    macro_rule to the one used for module_phy_driver. I noticed, if I made =
a
    driver that does not use kernel::prelude::*, that the ThisModule type
    identifier used in the macro would cause an error without being scoped =
in
    the macro_rule. I believe the correct implementation for the macro is o=
ne
    where the types used are correctly expanded with needed scopes.

 rust/kernel/net/phy.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 910ce867480a..80f9f571b88c 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -837,7 +837,7 @@ const fn as_int(&self) -> u32 {
 ///         [::kernel::net::phy::create_phy_driver::<PhySample>()];
 ///
 ///     impl ::kernel::Module for Module {
-///         fn init(module: &'static ThisModule) -> Result<Self> {
+///         fn init(module: &'static ::kernel::ThisModule) -> Result<Self>=
 {
 ///             let drivers =3D unsafe { &mut DRIVERS };
 ///             let mut reg =3D ::kernel::net::phy::Registration::register=
(
 ///                 module,
@@ -899,7 +899,7 @@ struct Module {
                 [$($crate::net::phy::create_phy_driver::<$driver>()),+];
=20
             impl $crate::Module for Module {
-                fn init(module: &'static ThisModule) -> Result<Self> {
+                fn init(module: &'static $crate::ThisModule) -> Result<Sel=
f> {
                     // SAFETY: The anonymous constant guarantees that nobo=
dy else can access
                     // the `DRIVERS` static. The array is used only in the=
 C side.
                     let drivers =3D unsafe { &mut DRIVERS };

base-commit: 73af53d82076bbe184d9ece9e14b0dc8599e6055
--=20
2.44.1



