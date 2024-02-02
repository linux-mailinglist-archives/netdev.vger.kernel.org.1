Return-Path: <netdev+bounces-68300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97316846718
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 05:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEA21F26A17
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 04:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB128F51C;
	Fri,  2 Feb 2024 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEjRnvol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE211F50A;
	Fri,  2 Feb 2024 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706849385; cv=none; b=hUZI5It8TrJKtEhXYNZ3ItCmx8cW/Dl5qALz+wp9kVeRlDUj/3RvonFcUjQBkq92Nn+LbLkgs00SecMMMbRdi8wG7pxnBOhzF+Aqhs9HuD5N/W9VuUVDtLjtNgfqxogWXzRpAUhlkKI4x3Hunb0EAX5UCoyK+YiycaxJK4F7JQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706849385; c=relaxed/simple;
	bh=p8u/p49T/Z1NsCb5F6vJsOqMcFKFcbtDyFkXHEsYn8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p63Pt/ftg8h+eymqTS6UuUtCLSAceea/CKZkee0GzL2Kzd/K1wQxfhIQXWO9y4NRisgWEBf/EtQGnB1C8R4UT8PejF0cclH/LPS7uRxSqEEPyjxpJ1DZQ4JJEzwMUHDlvZzTXZgexCn7DtpkiCNng7BwGHqA0o6Axy6wK82qPZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEjRnvol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACCBC433C7;
	Fri,  2 Feb 2024 04:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706849385;
	bh=p8u/p49T/Z1NsCb5F6vJsOqMcFKFcbtDyFkXHEsYn8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EEjRnvolmBUrWPHRQiSt0BdVbedftxQixVd5xTBz2ZPifeSxRTipuEPg6CCDyP8ks
	 VQtvo5ixz/jIUiglriib/579uYI02oyYOxfWUS+eBLuPmgsBwGeKM4PwGq0Bd+AK4+
	 yfzBYF0GCRfAcdhdAkAKCBGchLSpb+Iw3O+37nyzAMw7n0+nzCVNRHx03vWeRzk1ZS
	 qRdonSZZD1AcJjqUY53vNc9+mrKF9Z7vBI2/BqMC0H1CRK+2cn304Rx5V2ZgKmPQzm
	 6Btkmi5Z7Bn8IR71F8O5u1ED9WzhWKdCaDY3pY4Qjh6WZUjuPl2sSx0enyeTXVhTUw
	 6aB8Gz6fENXNg==
Date: Thu, 1 Feb 2024 20:49:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com,
 netdev@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 bridge@lists.linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/5] net: switchdev: Add helpers to display
 switchdev objects as strings
Message-ID: <20240201204940.5f5b6e85@kernel.org>
In-Reply-To: <20240130201937.1897766-3-tobias@waldekranz.com>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
	<20240130201937.1897766-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 21:19:34 +0100 Tobias Waldekranz wrote:
> Useful both in error messages and in tracepoints.

Are you printing things together into one big string?
Seems like leaving a lot of features on the table.
trace point events can be filtered, not to mention attaching
to them with bpftrace. 
There's also a built-in way to show traces how to convert numerical ids
to strings for the basic output - __print_symbolic().
None of that can help here?

