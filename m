Return-Path: <netdev+bounces-166110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28416A348A1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3297016165B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3377515697B;
	Thu, 13 Feb 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/g/2Lx9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9126B08B
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462156; cv=none; b=BOo2PJlBBSVXEjRdeo0d3Nhiz01ykhT+QzCFx2hPxft+KxKvS66J5oU1e2x8XVCAbJkODmTT9y1Xvhu19FIX2hbNzAKWrhKhd66CzIRYtAUARgGl5ehFsGlQ9SR6p/z1XxKluAkiWVEISpd5q9T4ZZ6lzV8yr9BXnb7QGHHDVb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462156; c=relaxed/simple;
	bh=As4A3F2x4T6WG3BiVDI+FWXkuLs/CQUC3Q20B9QmIeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujBFwupdzgSc5PT25OHx6wnV079sIuPBEwQ3aO/chVtwIsJQQ8xgGTv3rSWUcTzcl0mjnORrAssEf0kqL/R8ylHoSMISYdKD4je40eXW4jO9W7uS6bGB9I6vEK5ph8GCQGr8NHDPFUWQ6RzWYsTG5MbMLQTvJoBj/Fm808+xgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/g/2Lx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FC0C4CED1;
	Thu, 13 Feb 2025 15:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739462155;
	bh=As4A3F2x4T6WG3BiVDI+FWXkuLs/CQUC3Q20B9QmIeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U/g/2Lx99ijcSkc27Z7tT5XYi/k2jYdpiaP9Ad4whIO1iqJPAyoPuMey2e9MXwJzY
	 4cfcihV8nj72SqME4AslFU5oaQmx0dyP7uCy6jJ1zrmCRtnfb/FJs6wa2AvuhSH7XQ
	 jgAZZd2qKY/gmcLcfXSIsUjSkUlB04/upXSkqe6o9dNUMkbqGgD9J+9J4nndwUN505
	 TSqg5kQROIGotZRLnZXSpEVy6HrgsG54nSaEpSQ6dICl6BRU93Bw8simsPDONas2w3
	 gV0d3Ebu0Xwu+lrUNAyz8KcHtqVGyJ6ST6x66YQnu9rTvOTEyzmmuT/5tSo2OwUuSd
	 gjp41gAEsrx6A==
Date: Thu, 13 Feb 2025 07:55:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <willemb@google.com>, <shuah@kernel.org>
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: resolve remote
 interface name
Message-ID: <20250213075554.08a1406e@kernel.org>
In-Reply-To: <87o6z5di4m.fsf@nvidia.com>
References: <20250213003454.1333711-1-kuba@kernel.org>
	<20250213003454.1333711-2-kuba@kernel.org>
	<87o6z5di4m.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 15:31:57 +0100 Petr Machata wrote:
> > +    def resolve_remote_ifc(self):
> > +        v4 = v6 = None
> > +        if self.remote_v4:
> > +            v4 = ip("addr show to " + self.remote_v4, json=True, host=self.remote)
> > +        if self.remote_v6:
> > +            v6 = ip("addr show to " + self.remote_v6, json=True, host=self.remote)
> > +        if v4 and v6 and v4[0]["ifname"] != v6[0]["ifname"]:
> > +            raise Exception("Can't resolve remote interface name, v4 and v6 don't match")
> > +        return v6[0]["ifname"] if v6 else v4[0]["ifname"]  
> 
> Is existence of more than one interface with the same IP address a
> concern? I guess such configuration is broken and wouldn't come up in a
> selftest, but consider throwing in an "len(v4) == len(v6) == 1" for
> robustness sake. 

Will do!

> I guess it could in fact replace the "v4 and v6" bit.

Hm, I think that bit has to stay, we only record one interface.
So if v4 and v6 given to the test are on different interfaces
there could be some confusion. Not that we currently validate
the same thing for the local machine..

