Return-Path: <netdev+bounces-142529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAC19BF84C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436AF28357B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3A21C3050;
	Wed,  6 Nov 2024 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="TR2f244j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1-04.simnet.is (smtp-out1-04.simnet.is [194.105.232.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09171514CC
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926997; cv=none; b=sYydu7a14O5uzbwNuvyyH0OiwCUN99ALtw91Nzl38f4XDQ/bTYc8ifkNiq0PSmvRKaYyKZrtnQ1K8L+8NF6IK3yR4UHZSjDoGOZVxIxyh7ifIdRDqtbW9WzTLcHV4dAPwC0b6p3CNzx+F43JsKsXamkewwClUZWc1TXwJJ3VabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926997; c=relaxed/simple;
	bh=ry+yKZUAct1GeUWZiAlHToM90S4FaP6u02Vx1pkfqsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ep957sTbFNHFV10L5dkGXxMnqjb6hFjbA4EqnVO2fB8LpCuQD5USGANRSPru+RoElKqY3aXsvYmF1ngbJcqjWQT76qO3YS0hYTVr+Vnc6B1kF1ZSlpMsROfamoiZsyrvpxNkIrj/PbYEyfmoYur3W7x/bWAwTNmuZ4bBU8XZddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=TR2f244j; arc=none smtp.client-ip=194.105.232.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1730926994; x=1762462994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LzZEzmGQJKqB0AJj97PC3MkUxsVLaJECE5jS+dOMEq0=;
  b=TR2f244jLn5SzXFr7DUQMv5LG57SwAuJ/IRoRul4AbAX2s8b0R9EQ/0V
   EQnWljRC1PqMpYqejYMcbTPYZd9CYdYqu3HXfmnIBCbLk+NGlQJO906gS
   WaeO2wA/C4UqW0wGluvn2k24Ll++6i5d02tr2EyTFn2pVPQQVmTae/02n
   gD54ls75DQDRG2+cs+1EAT1PLpjxhtzWGUxFOloucZR117iRFFexeoCDW
   B61RLO6D5EHAT7TR7nuRoLVP1E/txpSEaHECdBrJhbgzWf3sG08uHtSxi
   PcyPmg9pnfY0y5WICUgyJzxOWGm8GRvUPTxKFP/hW/p1d/5l+kI1hUGSi
   w==;
X-CSE-ConnectionGUID: dMwSisJzTbSoF9ArKUiaMg==
X-CSE-MsgGUID: pH0zBABrS9af6RAA5pVCKQ==
Authentication-Results: smtp-out-04.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 3.3
X-IPAS-Result: =?us-ascii?q?A2FVAAAb0ytnhVfoacJaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgmGWR6AiAQEBD0QEAQGPQSg3Bg4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEOAQEGAQEBAQEBBgcCEAEBAQFADjuFNVOGYwEFOj8QCxguEEYGE4MBgmWwZ?=
 =?us-ascii?q?YE0gQHeM4FtgUgBhWmCYgGFaYR3PAaCDYFKgnU+iwcEgkiFIiWJFZgXUnscA?=
 =?us-ascii?q?1khEQFVExcLBwWBKiQsA4JTf4E5gVEBgx9Kgz0cgUIFNwo/gkppSzoCDQI2g?=
 =?us-ascii?q?iR9gk6DGIIFgQuDZYRpgUMdQAMLbT01FBufQEaCZ4MZx1WEJKFZM5c/DJMCm?=
 =?us-ascii?q?HepIoF9ggAsBxoIMIMiUhkP00N4OwIHCwEBAwmTXQEB?=
IronPort-PHdr: A9a23:+vx+URMixi7ZH34jLB4l6ncoWUAX0o4cXyYO74Y/zrVTbuH7o9L5P
 UnZ6OkrjUSaFYnY6vcRje3QvuigXGEb+p+OvTgEd4AETB4Kj8ga3kQgDceJBFe9LavsaCo3d
 Pk=
IronPort-Data: A9a23:dLLpw6gqlT7Xtn3N08OmNt6DX161cBAKZh0ujC45NGQN5FlHY01je
 htvWWGCb/2MMGL3KIt/YYSw8UwF6JXWmt5nHAZu+CkwEHhjpJueD7x1DG+pZHrKcZeroGGLT
 ik6QoOdRCzhZiaE/n9BCpC48D8kk/nOH+KgYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWctWo4ow/jb8k825ays4GhwUmEWPJingnePxhH5M7pHTU2BByOQapVZGOe8W
 9HCwNmRlo8O105wYj8Nuu+TnnwiGtY+DyDX4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TEz9BxN0AtH58k8N1wLzBn7
 98lKTkoYUXW7w626OrTpuhEmMU4MIz5PYYHoHZw3HSBVLA4QIvfBaTRjTNa9G5h2oYXRauYP
 ZFDL2owBPjDS0Qn1lM/Ap0Wh+atgHTjNTxDwL6QjfBrvzWKkFIuuFTrGML1Is6gbO9PpReRq
 Dz81k2kGi8xF+XKnFJp9Vr32r+ewnKnMG4IL5Wj6vNygFCV7moeFAIRT1ijpeS8gEOkHdVFJ
 CQ8/CcyoaUs3FKkQ8O7XBCipnOA+BkGVLJt//YS9gCW1u/G4gOBHG8UX3sZMZo4tdQqAz0xv
 rOUoz/3LTBKr4aUUlCPyr2vqh3jEDI2EG4LQCBRGGPp/OLfiI00ixvOSPNqH6i0ksD5FFnML
 9ai8HdWa1I70Z5j6kmrwW0rlQ5AsbDodWYICuj/QGO+8kZrZYu9fYu4+B2DtLBeLZ2FCFia1
 JTlpyR8xL5XZX1uvHXcKAnoIF1Pz63ZWNE7qQU2d6TNDxz3pxaekXl4uVmS3ntBPMceYiPOa
 0TOow5X75I7FCL1NvcnONvtW5hxkvSI+THZuhb8MoUmjn9ZKVfvwc2STR7Mt4wQuBFwyv9mZ
 /93j+72XShHYUiY8NZGb7xBge50l3xWKZL7QJH/xlyn39KjiI29FN843K+1Rrlhtsus+VyJm
 /4BbJHi40sED4XDjtz/qtV7waYidiNjXcieRg0+XrLrHzeK70l7VaGInelwIdU+90mX/8+Rl
 kyAtoZj4AKXrRX6xc+iNhiPtJuHsU5DkE8G
IronPort-HdrOrdr: A9a23:07H0Wa+J55oCzlKKex1uk+DpI+orL9Y04lQ7vn2ZKCYlFPBw8v
 rE9sjzuiWE8Ar5NEtPpTmrAsm9qArnhPpICNAqTNCftWrd2VdATrsSlLcKqgeIcxEWndQw6U
 4PScVD4LaaNykZsS6TizPIcOrIuOPpzElev5a680tQ
X-Talos-CUID: 9a23:DlqyamM+8ljQde5DVAx4z08PONIZeEba4ib5OWyFCG9MR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3ACi7pTg/460GCenMmWqQ4ynGQf99Iu7aEIWoXqsQ?=
 =?us-ascii?q?PtZe+HAUtIwm2rw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,263,1725321600"; 
   d="scan'208";a="24451467"
Received: from vist-zimproxy-01.vist.is ([194.105.232.87])
  by smtp-out-04.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 21:03:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id C863F41A16AD;
	Wed,  6 Nov 2024 21:03:05 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10032)
 with ESMTP id p9UkZtL0fdB7; Wed,  6 Nov 2024 21:03:05 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTP id 9337D41A16AE;
	Wed,  6 Nov 2024 21:03:05 +0000 (GMT)
Received: from vist-zimproxy-01.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-01.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id nIf9SH2zluoO; Wed,  6 Nov 2024 21:03:05 +0000 (GMT)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-01.vist.is (Postfix) with ESMTPS id 68B0341A16AD;
	Wed,  6 Nov 2024 21:03:05 +0000 (GMT)
Received: from bg by kassi.invalid.is with local (Exim 4.98)
	(envelope-from <bg@kassi.invalid.is>)
	id 1t8nBC-000000000qd-1TIA;
	Wed, 06 Nov 2024 21:03:06 +0000
Date: Wed, 6 Nov 2024 21:03:06 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: dcb-pfc.8: some remarks and editorial changes for this manual
Message-ID: <ZyvZigs-RWzjI0H2@kassi.invalid.is>
References: <ZyrAxcsS04ppanYT@kassi.invalid.is>
 <20241106091046.2a62f196@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106091046.2a62f196@hermes.local>

On Wed, Nov 06, 2024 at 09:10:46AM -0800, Stephen Hemminger wrote:
> On Wed, 6 Nov 2024 01:05:09 +0000
> Bjarni Ingi Gislason <bjarniig@simnet.is> wrote:
> 
> >   The man page is from Debian:
> > 
> > Package: iproute2
> > Version: 6.11.0-1
> > Severity: minor
> > Tags: patch
> > 
> >   Improve the layout of the man page according to the "man-page(7)"
> > guidelines, the output of "mandoc -lint T", the output of
> > "groff -mandoc -t -ww -b -z", that of a shell script, and typographical
> > conventions.
> > 
> > -.-
> > 
> >   Output from a script "chk_man" is in the attachment.
> > 
> > -.-
> > 
> > Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>
> 
> Is the last of the dcb man changes?

The last but one (already submitted).

"devlink-*' are also marked, but that will wait until other man pages in
other packages have been dealt with.


