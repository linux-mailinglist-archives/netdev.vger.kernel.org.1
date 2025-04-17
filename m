Return-Path: <netdev+bounces-183601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE08A91355
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B8C3BF241
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 05:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CA91E1DEB;
	Thu, 17 Apr 2025 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDz4BW+w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2941DE4C8;
	Thu, 17 Apr 2025 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744869255; cv=none; b=jj1UFXMOPhhVoqwdfwtqjdXJP6ChDGjcjQdT7LEmVzyyh3xR5vjXaQ6JSMK/Sel9NBW3XM5KmCNBHAgVm4BTdFowe2mZU/slkM0SKAtpVkFSUtNF/tPHvtc1HKT1oBgTXEqapcnRqDPRSZrrV/PLFEZbe2VTPf+xFn4/diHtXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744869255; c=relaxed/simple;
	bh=K56yBMbgQGqljUDT9Hv9xg/jrxYHjS/4JS/AZXqh1NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fR2ncDl85E64wiwiYGE5hLAfxoCvf4wQ6UEG4rYSqX9w0tyDStjflkTBGTc8BAma/cNGppk/vskbeiRuanqA3A6BI/1qiDqUJk4ybcykuVX/lVMi2sRlOKCR9+jAGfq+P5AF26bNdxskWwai9aVwK/gP0Z+yNgP0GJ/pM38eTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDz4BW+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449B8C4CEE4;
	Thu, 17 Apr 2025 05:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744869254;
	bh=K56yBMbgQGqljUDT9Hv9xg/jrxYHjS/4JS/AZXqh1NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDz4BW+w38peZmiAvsJJ0jOI3cOSWwnlLdeCnuh9/hErkGh5mFB0jQcHTLLznPSvv
	 Elqy4aILvNhnKYoPVE3TT2qdXlsGrZP1LfR7p+nOrGBMOxYhT+Ppxv74SZ9cRlg+VU
	 fCZflPW/IXpvtPVjCOoJb+b8cCFRfwbO5LWTDmA4QUV+9KD2x6DYTG0WhGkvOVQ+Ne
	 gXK3WoRLaKr8ztyzzMoq0SklQ+1aKyaw5XyKw5Vwz49d0uqhyEDBj32H3J4gk9cZRe
	 VEvqV64S7dlf7jMjilqZkt69bKHigdE9FKFY4iRinV4j/N+9qQDBz/E4qBb2hbZTf4
	 AY5R65rI6zDCQ==
Date: Thu, 17 Apr 2025 07:54:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Kees Cook <kees@kernel.org>, Michal Schmidt <mschmidt@redhat.com>, 
	Conor Dooley <conor+dt@kernel.org>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 2/8] dt-bindings: dpll: Add support for
 Microchip Azurite chip family
Message-ID: <20250417-warping-weightless-puffin-d1c9c8@shite>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-3-ivecera@redhat.com>
 <174482532098.3485034.14305412993449574460.robh@kernel.org>
 <CAAVpwAurYhW1Eyw7C_gPY0cTrQJrw7o_FL3-npLdWsxE=FGXkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAVpwAurYhW1Eyw7C_gPY0cTrQJrw7o_FL3-npLdWsxE=FGXkg@mail.gmail.com>

On Wed, Apr 16, 2025 at 08:29:33PM GMT, Ivan Vecera wrote:
> On Wed, Apr 16, 2025 at 7:42=E2=80=AFPM Rob Herring (Arm) <robh@kernel.or=
g> wrote:
> >
> >
> > On Wed, 16 Apr 2025 18:21:38 +0200, Ivan Vecera wrote:
> > > Add DT bindings for Microchip Azurite DPLL chip family. These chips
> > > provides up to 5 independent DPLL channels, 10 differential or
> > > single-ended inputs and 10 differential or 20 single-ended outputs.
> > > It can be connected via I2C or SPI busses.
> > >
> > > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > > ---
> > > v1->v3:
> > > * single file for both i2c & spi
> > > * 5 compatibles for all supported chips from the family
> > > ---
> > >  .../bindings/dpll/microchip,zl30731.yaml      | 115 ++++++++++++++++=
++
> > >  1 file changed, 115 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/dpll/microchip,=
zl30731.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/dpll/microchip,zl30731.yaml: $id: Cannot determine base path from $id, rel=
ative path/filename doesn't match actual path or filename
> >          $id: http://devicetree.org/schemas/dpll/microchip,zl3073x.yaml
>=20
> Oops, my bad... I forgot to update $id after rename of the file...
> Will fix.

No, you forgot to test. You are expected to build your code (and this is
here testing) BEFORE you post, not after or not through community
resources.

