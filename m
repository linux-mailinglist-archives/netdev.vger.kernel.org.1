Return-Path: <netdev+bounces-172605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D671A557D9
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429DA177643
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864842063DD;
	Thu,  6 Mar 2025 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3QW16Lf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770511FDA95;
	Thu,  6 Mar 2025 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294354; cv=none; b=RYF2DLcOBD7eIJXrMHdOGNG3GoUgcCbPTdDelcQpCw407WkGzz/Ti5cYkX/JV99k/Hok1Jlb6NSmit+fAULHbzih37MpgUUnrzjMiwBdN0US60anwnos/fQQ/sC+zSRbew6Auoa/WXwfVMED/04tXHzpMt7ThA5xgjzpJIdBjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294354; c=relaxed/simple;
	bh=9/k5vAQPlllkqeoVC6KPl7jGub6QSCj8r/sPKoAFx1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g7k6F2YU7o3QwPfnrd5MtkMaLD8nVLZAFOjk82NXFLIlObCV5w/WckkSM0tHz0HxALuKQjWpMSvgb7rxxDUk4hJd3y1SGYLRNpvD4YZX3yTPvZUn0HVBPP7vKPGQi1Y3rq1TtfcoOFpOYtCAP71u7OOBlxyGFiKM1DNxMD02IIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3QW16Lf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741294353; x=1772830353;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=9/k5vAQPlllkqeoVC6KPl7jGub6QSCj8r/sPKoAFx1g=;
  b=c3QW16LfQu9N9mwn3bu8pONq73SRiljS6MplTMxFKjlY8ez74fMLUGw6
   xTXV8ZnqMq9y50fcSRlQ8RDLiuejZI8QdhetCnq65Ll+B1sqCkeMuc+L8
   5j2wc32h5S9bwdCqVeN78JMIqNG8LAymfXzBF9EcrhMY6Bic5jYmjnT3M
   newRWmcEku0sI2e6vqfilE8K2Kbq2Yc0YWKUX/Jj9xWTFhbfLWIqqvhHj
   mUKpjzkWy50arv4IfLybF+StQnjT5HkkPuaCodFTJBLaz/S0FaCm/EDoD
   4oxLfK77m+tFsXDeHWa3xdzcEIhRxLPwEUMJck8IIEV5aw8OnO1q3xetx
   A==;
X-CSE-ConnectionGUID: qlhqbYJFSDeiQzRGsg4zBQ==
X-CSE-MsgGUID: u6ShGmhiTQ6ckWZWSYYxsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="45135667"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="45135667"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:52:32 -0800
X-CSE-ConnectionGUID: NWY+K21hQYiBE5DOFr55fw==
X-CSE-MsgGUID: sBEcyVq0Q/OUlTi1Db5nYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156354902"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:52:32 -0800
Received: from [10.54.75.34] (debox1-desk1.jf.intel.com [10.54.75.34])
	by linux.intel.com (Postfix) with ESMTP id 455C920B5736;
	Thu,  6 Mar 2025 12:52:31 -0800 (PST)
Message-ID: <257769403908de3ac6271059e1febee88654fbdc.camel@linux.intel.com>
Subject: Re: [PATCH net-next v9 5/6] net: stmmac: configure SerDes according
 to the interface mode
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>, Andy Shevchenko
	 <andy.shevchenko@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>, Jose
 Abreu <Jose.Abreu@synopsys.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Rajneesh
 Bhardwaj <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Hans de Goede
 <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Richard Cochran
 <richardcochran@gmail.com>, Serge Semin <fancer.lancer@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Thu, 06 Mar 2025 12:52:31 -0800
In-Reply-To: <d7c0094e-7fd3-4113-8d00-91b7a83ffd1f@linux.intel.com>
References: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
	 <20250227121522.1802832-6-yong.liang.choong@linux.intel.com>
	 <Z8lLm9Ze9VAx3cE_@surfacebook.localdomain>
	 <601c88fb-8ec8-4866-a45d-f28dea6d9625@linux.intel.com>
	 <CAHp75VeOKbAsvSuf5+VQnGFmUcN92TNnR2eF1+70h3PjaMdMqA@mail.gmail.com>
	 <d7c0094e-7fd3-4113-8d00-91b7a83ffd1f@linux.intel.com>
Autocrypt: addr=david.e.box@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBF2w2YABCACw5TpqmFTR6SgsrNqZE8ro1q2lUgVZda26qIi8GeHmVBmu572RfPydisEpCK246rYM5YY9XAps810ZxgFlLyBqpE/rxB4Dqvh04QePD6fQNui/QCSpyZ6j9F8zl0zutOjfNTIQBkcar28hazL9I8CGnnMko21QDl4pkrq1dgLSgl2r2N1a6LJ2l8lLnQ1NJgPAev4BWo4WAwH2rZ94aukzAlkFizjZXmB/6em+lhinTR9hUeXpTwcaAvmCHmrUMxeOyhx+csO1uAPUjxL7olj2J83dv297RrpjMkDyuUOv8EJlPjvVogJF1QOd5MlkWdj+6vnVDRfO8zUwm2pqg25DABEBAAG0KkRhdmlkIEUuIEJveCA8ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPokBTgQTAQgAOBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH7Mry1gl3p/NusIAK9z1xnXphedgZMGNzifGUs2UUw/xNl91Q9qRaYGyNYATI6E7zBYmynsUL/4yNFnXK8P/I7WMffiLoMqmUvNp9pG6oYYj8ouvbCexS21jgw54I3m61M+wTokieRIO/GettVlCGhz7YHlHtGGqhzzWB3CGPSJMwsouDPvyFFE+28p5d2v9l6rXSb7T297Kh50VX9Ele8QEKngrG+Z/u2lr/bHEhvx24vI8ka22cuTaZvThYMwLTSC4kq9L9WgRv31JBSa1pcbcHLOCoUl0RaQwe6J8w9hN2uxCssHrrfhSA4YjxKNIIp3YH4IpvzuDR3AadYz1klFTnEOxIM7fvQ2iGu5AQ0EXbDZgAEIAPGbL3wvbYUDGMoBSN89GtiC6ybWo28JSiYIN5N9LhDTwfWROenkRvmTESaE5fAM24sh8S0h+F+eQ7j/E/RF3pM31gSovTKw0Pxk7GorK
	FSa25CWemxSV97zV8fVegGkgfZkBMLUId+AYCD1d2R+tndtgjrHtVq/AeN0N09xv/d3a+Xzc4ib/SQh9mM50ksqiDY70EDe8hgPddYH80jHJtXFVA7Ar1ew24TIBF2rxYZQJGLe+Mt2zAzxOYeQTCW7WumD/ZoyMm7bg46/2rtricKnpaACM7M0r7g+1gUBowFjF4gFqY0tbLVQEB/H5e9We/C2zLG9r5/Lt22dj7I8A6kAEQEAAYkBNgQYAQgAIBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsMAAoJEH7Mry1gl3p/Z/AH/Re8YwzY5I9ByPM56B3Vkrh8qihZjsF7/WB14Ygl0HFzKSkSMTJ+fvZv19bk3lPIQi5lUBuU5rNruDNowCsnvXr+sFxFyTbXw0AQXIsnX+EkMg/JO+/V/UszZiqZPkvHsQipCFVLod/3G/yig9RUO7A/1efRi0E1iJAa6qHrPqE/kJANbz/x+9wcx1VfFwraFXbdT/P2JeOcW/USW89wzMRmOo+AiBSnTI4xvb1s/TxSfoLZvtoj2MR+2PW1zBALWYUKHOzhfFKs3cMufwIIoQUPVqGVeH+u6Asun6ZpNRxdDONop+uEXHe6q6LzI/NnczqoZQLhM8d1XqokYax/IZ4=
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-3.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-06 at 20:56 +0800, Choong Yong Liang wrote:
>=20
>=20
> On 6/3/2025 5:05 pm, Andy Shevchenko wrote:
> > On Thu, Mar 6, 2025 at 10:39=E2=80=AFAM Choong Yong Liang
> > <yong.liang.choong@linux.intel.com> wrote:
> > > On 6/3/2025 3:15 pm, Andy Shevchenko wrote:
> > > > Thu, Feb 27, 2025 at 08:15:21PM +0800, Choong Yong Liang kirjoitti:
> > ...
> >=20
> > > > > config DWMAC_INTEL
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default X86
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on X86 && STMMAC_ETH && PC=
I
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on COMMON_CLK
> > > > > +=C2=A0=C2=A0=C2=A0 depends on ACPI
> > > > Stray and unexplained change. Please, fix it. We don't need the
> > > > dependencies
> > > > which are not realised in the compile time.
> > > The dependency on ACPI is necessary because the intel_pmc_ipc.h heade=
r
> > > relies on ACPI functionality to interact with the Intel PMC.
> > So, that header has to be fixed as ACPI here is really unneeded
> > dependency for the cases when somebody (for whatever reasons) want to
> > build a kernel without ACPI support but with the driver enabled for
> > let's say PCI device.
> >=20
> >=20
> > -- With Best Regards, Andy Shevchenko
>=20
> Hi Andy,
>=20
> Thank you for your feedback, Andy.
> I appreciate your insights regarding the ACPI dependency.
> The intel_pmc_ipc.h header is under the ownership of David E Box, who=20
> focuses on the platform code, while my focus is on the netdev.
>=20
> Hi David,
>=20
> if you could kindly look into making the ACPI dependency optional in the=
=20
> intel_pmc_ipc.h header, it would be greatly appreciated.
> I am more than willing to provide any support necessary to ensure a smoot=
h=20
> resolution.

Choong you only need put the function under a #if CONFIG_ACPI block and pro=
vide
an alternative that returns an error when the code is not build. Like this,

#if CONFIG_ACPI
static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc=
_rbuf
*rbuf)
{
   ...
}
#else
static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc=
_rbuf
*rbuf) { return -ENODEV; }
#endif

David

>=20
> This patch series has already been accepted, but we recognize the=20
> importance of addressing this issue in the next patch series for upstream=
.
> Our goal is to ensure that the driver can be compiled and function=20
> correctly in both ACPI and non-ACPI environments.
>=20
> Thank you both for your understanding and collaboration.


