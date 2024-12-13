Return-Path: <netdev+bounces-151722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11709F0BB3
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D85281EC8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE81DE899;
	Fri, 13 Dec 2024 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3oGSOBY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4004A21
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090900; cv=none; b=b9BZ010LoSBdhpV33UkyCZ2+reaE+mVswDKThURlsDy4zAZXlPEWnogoOvY0EPak98L+MQphElaQk/tx5FpCc2BOCAazIq5uxPsIduozBxvLj6Fp2ZbR+heB8La7+lXDymghVucLSLSuEn4QZvCFyIJ7jS76M1DgkGxWwOS/t4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090900; c=relaxed/simple;
	bh=yerIgJaV5A6Rde5kjoCtHKFrLDMP5haBZrIi+LOjhWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C24ca/GyfeUd++wJnLQSyciNiQKfuLkfrTb0PC0Gt0tCYw1zSTAnBBUcBUSxiDaAXVSgHa+hBumQnsr361puMsOWoXRNy5Lay8kcmr9dlT2wfFaGRS9o/zZWDhgA3A+rFeHAQNyV9carnTlE8giP3vX3ZDDd7p7j4F59UqKoDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3oGSOBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2C1C4CED0;
	Fri, 13 Dec 2024 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734090900;
	bh=yerIgJaV5A6Rde5kjoCtHKFrLDMP5haBZrIi+LOjhWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3oGSOBYXGFvw/H33jRiRJvt5B00lfqnqAkvb7tOu/YojDdnm2YUsyB5tw/k6xSFm
	 0rSGRIqFl++x0PkeMFjrvNhX5XNW37h2vBI7PG+lNmrtxNkeVGMhIA705gHU2K/i0p
	 64Kk8MxvuZzD4G7x6kvUoGeW1VHlow2Zbfz4D2McRG5clzMbc7MjLzkIb+Q7Tyqvk8
	 DQkgWjyED3z+Mkwdom9xGvx+gEHlfqK2Q8DKIfj+tTAPLaSSQRootijEWktot38DJf
	 CkrQ/EC6gGEZkXMtFy/RtLMv1eN9aY5Z202wz/52viyZKf46jfIe5pcpTOUroChrdn
	 0m1rS24nun5uw==
Date: Fri, 13 Dec 2024 11:54:56 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH iwl-next 1/3] ice: downgrade warning about
 gnss_insert_raw to debug level
Message-ID: <20241213115456.GQ2110@kernel.org>
References: <20241212153417.165919-1-mschmidt@redhat.com>
 <20241212153417.165919-2-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212153417.165919-2-mschmidt@redhat.com>

On Thu, Dec 12, 2024 at 04:34:15PM +0100, Michal Schmidt wrote:
> gnss_insert_raw() will reject the GNSS data the ice driver produces
> whenever userspace has the gnss device open, but is not reading it fast
> enough for whatever reason.
> 
> Do not spam kernel logs just because userspace misbehaves.
> 
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


