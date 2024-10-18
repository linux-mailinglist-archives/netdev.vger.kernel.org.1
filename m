Return-Path: <netdev+bounces-137024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C433D9A40A1
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6751B280FAE
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4837603A;
	Fri, 18 Oct 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2KrzJFd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA06F2FE
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260311; cv=none; b=gidtGz/4Ufc0kSV9VYo6Leq4CS/kRNQ3fAD0gh4XoaYcGK1Lt9UMtA/+zBuAw8Sa7b+nNWFxd8MPG54qWuzD3OoT049nBoYkqjybPH+hDzpgCjqtVstxt/39wnhj24yAsc8YOGk5uYuY7ELG+UwAC0U89eK+wQbUJyssvSRHY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260311; c=relaxed/simple;
	bh=R9lWypop9CYn5IZM0AimYM8p1o0ocB7VwyHTdtaK9+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAbn7VmwpfdwvkZ47yOBkM77/+KyUQsfnJab4YeKIdoAIvN+e6YXA9ypgdSPPUO0uv8F32kV30yNxrh4IZ4Gi+r1JmF39kASo3H7vPDEGQYxpsCUkzkwbRsNdchKYBmhtXRhewMvUos05YDWDW/YZTGxNZO7UtFxv7VmQ3d7jSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2KrzJFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C73C4CEC7;
	Fri, 18 Oct 2024 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260310;
	bh=R9lWypop9CYn5IZM0AimYM8p1o0ocB7VwyHTdtaK9+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2KrzJFdyx5Q0fLbzBijSTvTKJjEyGrD0KPVXKVairUmKL/Z7emdKCg5bg4mSc2VA
	 4RPZuU34JPA81MBh4RBYqodOKLMNEydrYnu4E5rGOaMiuenijw83y6WtSVMKWhaFcQ
	 yja93tki8oHsnmL2CJNnI6wrCv2bwUoWcylpglxIivnK6ZjytmPujveLygXv7yhX0o
	 IPdXpbrUtv6oU7UsPuIfhhUOfZa5trhlQogI9zpCF4bV3YCS0k4IHnbtJQra6mnEgL
	 RZQD1FqcZ5ErZOqdTnS9R7UC3pHxN18ECgakW1vKD5hdaq4Yr+2+rrQhJCq/qL0uW0
	 IUdcHz9CqXXRA==
Date: Fri, 18 Oct 2024 15:05:07 +0100
From: Simon Horman <horms@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: sysctl: remove always-true condition
Message-ID: <20241018140507.GM1697@kernel.org>
References: <20241017152422.487406-1-atenart@kernel.org>
 <20241017152422.487406-2-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017152422.487406-2-atenart@kernel.org>

On Thu, Oct 17, 2024 at 05:24:17PM +0200, Antoine Tenart wrote:
> Before adding a new line at the end of the temporary buffer in
> dump_cpumask, a length check is performed to ensure there is space for
> it.
> 
>   len = min(sizeof(kbuf) - 1, *lenp);
>   len = scnprintf(kbuf, len, ...);
>   if (len < *lenp)
>           kbuf[len++] = '\n';
> 
> Note that the check is currently logically wrong, the written length is
> compared against the output buffer, not the temporary one. However this
> has no consequence as this is always true, even if fixed: scnprintf
> includes a null char at the end of the buffer but the returned length do
> not include it and there is always space for overriding it with a
> newline.
> 
> Remove the condition.
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Thanks for separating out this and patch 2/3.
It makes it much easier to reason with these changes.

Reviewed-by: Simon Horman <horms@kernel.org>


