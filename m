Return-Path: <netdev+bounces-223760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E901B7DC0E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EABE460AB1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737512F9D8E;
	Tue, 16 Sep 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD87LcRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4574F2E0415;
	Tue, 16 Sep 2025 22:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061508; cv=none; b=VZUEzIHEqF7sn8FImSUl4BhO1BJ/c67u4bzQGDivAn9UhnrIYr1oKanifEEp0bsfRI9jBSUQW4c9fT0uDiQI5kZkzqKhf1a118oKOCppQzeD//oTNB/tzr43Q4V89TYJ010W/ZeSt6qQEDfJNCD67UldCaMakLgGHFcHlSIFfXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061508; c=relaxed/simple;
	bh=nGJevCQQM+jk8WF51U8oZX9k3szL6tUsmqXjvDGaFtU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zd+TRqjDMj0jEFXGIGzMOWQ9c8EdjjItMDcPGvYKsLS9A2P4wG0/8aWuwYyzMzuOa/MkqAFcuO3aplu+3OR1g+dHry7ZaONgB/xFl93S3wnV26OFTzcdMttcwp7Y3sIMswjdZqEKyTWxBkKmgoAbP5ZW4cWluAPpe6FODf4BK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD87LcRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B725C4CEEB;
	Tue, 16 Sep 2025 22:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758061507;
	bh=nGJevCQQM+jk8WF51U8oZX9k3szL6tUsmqXjvDGaFtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VD87LcRqrgC2cUXbsf+7gMpOOBQM8uL2XwEECySOE+BC1pqtpmgcfqzHplMsqGDQc
	 gpvFO0S7wYf9WQJYNbSIByw6pzmOALDN/H2t+ywBuvSmr8NQi16qcDxZIFh3NblRdj
	 UCi/PLX1GjoJsTK3YNmlQO5yE1g/+iksjWcVl3UGtjdrSkTZESa7XGXb2CCNsetexp
	 1XmWCzkO30ABsEJ/ZGIBf+Fw8UF/y1Wq9z0adnNSBU9wlb3QpAmuCrtL94ecPlWlfa
	 KmMgIgipqgHiUrAZripBq6VQJ2FP7aFi/0Yy2wnBJSpFcbBn1Jy3lUJAEdYThDJl+5
	 Zh3uvbI9s6hmg==
Date: Tue, 16 Sep 2025 15:25:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Arkadiusz
 Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH net-next v2] dpll: zl3073x: Allow to use custom phase
 measure averaging factor
Message-ID: <20250916152506.256ea653@kernel.org>
In-Reply-To: <FA93EFB9-954B-421E-97B2-AE9E0A0A4216@redhat.com>
References: <20250911072302.527024-1-ivecera@redhat.com>
	<20250915164641.0131f7ed@kernel.org>
	<FA93EFB9-954B-421E-97B2-AE9E0A0A4216@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 20:16:57 +0200 Ivan Vecera wrote:
> >> Add devlink device parameter phase_offset_avg_factor to allow a user
> >> set tune the averaging factor via devlink interface.  
> >
> >Is averaging phase offset normal for DPLL devices?  
> 
> I don't know... I expect that DPLL chips support phase offset
> measurement but probably implementation specific.

Ack, I was hoping Arkadiusz and Vadim could comment what their DPLL
devices do.

> >If it is we should probably add this to the official API.  
> 
> The problem in case of this Microchip DPLL devices is that this
> parameter is per ASIC. It is common for all DPLL channels
> (devices) inside the chip. That's why I chose devlink.
> 
> >If it isn't we should probably default to smallest possible history?  
> 
> Do you mean the default value?

Yes, but let's wait for others to chime in.

