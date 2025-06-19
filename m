Return-Path: <netdev+bounces-199406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC2CAE02AA
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCAC7A3E9B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEC2222D1;
	Thu, 19 Jun 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvF/pXNK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075517583;
	Thu, 19 Jun 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328970; cv=none; b=G3LPYU+UdyIvxkIM+ol5PpwJ/6CqImI46TxeJMkQEUd+IQCjLEdyJgos46ffunCz/L5ROm6yLB6IcVt8KD18bvExl96NH99XVjYpBQ+A6Kd4YQngcfcyF/N8OW82vWZ0/gEdRZoLCh7Cysp4Mc+HmAfpHrFKODJS/ESTeQLE1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328970; c=relaxed/simple;
	bh=MNnBbkAciZE0S7Viw3nX/mJtBpSM07OUpqTorFANR0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceK10UeZM6CptDcR+KyRleVRrJQI1wZ3tOaWEd04ZjRn0588hLzhiNT7ATQOb8f1WSm19fcUMU1gPLiqtzu0TZjdhXBbw8uuTBd3MAy9AEwv5u3/I5+OBg1Xk1wpmWsYiot42lQ7xChs+1XiVKpxX3Nq+kYHQk3DTS3hwt5GQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvF/pXNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77384C4CEEA;
	Thu, 19 Jun 2025 10:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750328970;
	bh=MNnBbkAciZE0S7Viw3nX/mJtBpSM07OUpqTorFANR0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvF/pXNKrJgFAMdCkX5ab8PNq+OE/jdUp9yd2SRYb1B+Jwz4Xk7fn3yhWZxogmEGn
	 pSbXyqv+KsQ2Nqn0o2F4RQcEXBeyM1yqThAECJrjhJstexE9BDEmZveJktyTaSxVud
	 SnoFQdKFCh3NKBUsbY8SC1C5WR+/h4LB4Hew0P5G0F92qyp82/QFfsCOstGpPzA0m5
	 zVhg879cEzLcFquauSqfVL9S8Z2SQunuqD7ylC3kw1UhnQobJpOzrXSzGVaKDlbPfo
	 C3LEqdRJKHL3JWdcYl6TQg1DrNBxcFbXcjJof3w/bBfDiVBoGzLYNXQ8VDmFvFMCI2
	 iFi65kqiKwsAA==
Date: Thu, 19 Jun 2025 11:29:26 +0100
From: Simon Horman <horms@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net] mailmap: Update shannon.nelson emails
Message-ID: <20250619102926.GH1699@horms.kernel.org>
References: <20250619010603.1173141-1-sln@onemain.com>
 <b58b716e-a009-4b9a-a071-3989662e9652@onemain.com>
 <a49f5447-eb5e-4b3a-9285-903536c71af7@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a49f5447-eb5e-4b3a-9285-903536c71af7@amd.com>

On Wed, Jun 18, 2025 at 06:33:47PM -0700, Nelson, Shannon wrote:
> On 6/18/25 6:06 PM, Shannon Nelson wrote:
> > Retiring, so redirect things to a non-corporate account.
> > 
> > Signed-off-by: Shannon Nelson <sln@onemain.com>
> > ---
> >   .mailmap | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/.mailmap b/.mailmap
> > index b77cd34cf852..7a3ffabb3434 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -691,9 +691,10 @@ Serge Hallyn <sergeh@kernel.org> <serge.hallyn@canonical.com>
> >   Serge Hallyn <sergeh@kernel.org> <serue@us.ibm.com>
> >   Seth Forshee <sforshee@kernel.org> <seth.forshee@canonical.com>
> >   Shakeel Butt <shakeel.butt@linux.dev> <shakeelb@google.com>
> > -Shannon Nelson <shannon.nelson@amd.com> <snelson@pensando.io>
> > -Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@intel.com>
> > -Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@oracle.com>
> > +Shannon Nelson <sln@onemain.com> <shannon.nelson@amd.com>
> > +Shannon Nelson <sln@onemain.com> <snelson@pensando.io>
> > +Shannon Nelson <sln@onemain.com> <shannon.nelson@intel.com>
> > +Shannon Nelson <sln@onemain.com> <shannon.nelson@oracle.com>
> >   Sharath Chandra Vurukala <quic_sharathv@quicinc.com> <sharathv@codeaurora.org>
> >   Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
> >   Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
> 
> In case there was any question, yes, this was me from home.

Reviewed-by: Simon Horman <horms@kernel.org>


