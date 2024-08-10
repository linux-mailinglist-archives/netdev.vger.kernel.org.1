Return-Path: <netdev+bounces-117348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612D994DA9B
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 06:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6791C20DCA
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 04:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278D412F5A5;
	Sat, 10 Aug 2024 04:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKJlNMoX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB08753A7;
	Sat, 10 Aug 2024 04:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723263351; cv=none; b=GAt5YdQzPB8Nsx05JF943h4QTMFrpKXpFHUld9ZY4LsR9ioWiXTdhJPMpr9YpWdpYgLMHGpIMJpd7Wtk62NVo3SadYxSQMxM5CoQ5aCqP2BBdZFDJYCNUaGQbWL3PEv92lsC6dbPfNvDnLicmltIeKIh+Nf3tzSN5h447zD8In0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723263351; c=relaxed/simple;
	bh=DsTex5w319t+W39m/nEPcF2eB9y2KGW7S5WuO7vGhIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxeL4aimUYSI2m5x7fg20yaPlfVcHBS7VwEEiUwVI0UbVxxlkt+d9WQU3+b1e5h0UM14CXiEXn3E0UZV+n8YcfHKkIdAWl7JjIzkNONLV0f9CNFsL/qCvKqOyZBdrabsifKY6wcIOR8+T6tgqDRKFhOt5FTHrHf5lOjt99Hq5Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKJlNMoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E40EC32781;
	Sat, 10 Aug 2024 04:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723263350;
	bh=DsTex5w319t+W39m/nEPcF2eB9y2KGW7S5WuO7vGhIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dKJlNMoXv7gx8cfES6UdDZhyuJJrX7BuuLni6LKNZvc38+xJVar7LA/Ss2qHJDtq+
	 jJvn3dVXn8ezVa1RaMskxVMC4nIGfzbCftRDEePOUKDPkC3CNa+mXsyiFFwhNmRFXM
	 7+xGv66g6YeeS+wCf6no+ACovtjR1FOqEEBTKb5U9IaRBfS4wj3aCIRGeW/SYoMaIr
	 cPh60y47Q9B5xhdYY1FsI49xjwVs+uQpgQpsryVniDBPB8ta2/y64zMKHD41D+Tmuo
	 5/wsJuD8DMh5Dw67WCDDu42URoZcyVy8iqr0jEzw1qN0503sOpkX8c09VkHrWGhhLs
	 FO0GtQFdo9Brg==
Date: Fri, 9 Aug 2024 21:15:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v1 1/2] dpll: add Embedded SYNC feature for a
 pin
Message-ID: <20240809211549.28d651d7@kernel.org>
In-Reply-To: <20240808112013.166621-2-arkadiusz.kubalewski@intel.com>
References: <20240808112013.166621-1-arkadiusz.kubalewski@intel.com>
	<20240808112013.166621-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Aug 2024 13:20:12 +0200 Arkadiusz Kubalewski wrote:
> +Device may provide ability to use Embedded SYNC feature. It allows
> +to embed additional SYNC signal into the base frequency of a pin - a one
> +special pulse of base frequency signal every time SYNC signal pulse
> +happens. The user can configure the frequency of Embedded SYNC.
> +The Embedded SYNC capability is always related to a given base frequency
> +and HW capabilities. The user is provided a range of embedded sync
> +frequencies supported, depending on current base frequency configured for
> +the pin.

Interesting, noob question perhaps, is the signal somehow well
known or the implementation is vendor specific so both ends have
to be from the same vendor? May be worth calling that out, either way.

