Return-Path: <netdev+bounces-81331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A39887416
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 21:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72741C21D73
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5489D7EF10;
	Fri, 22 Mar 2024 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujJW22Rn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7279955
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711137899; cv=none; b=tFrTkgsEAJ8qUGfhuWBHlcYR7L+o3NuDPylOXHw2wN4ai2mhuqyyT7RFKPzBpR086tyf64W8EufPijmO7+KH45lwM1MPA8iou47BByRjJjl+Nd0Ehd5TyG1VdMHJyQKIFWOjEdmqtXgpl4DGFUHr6CgdIRTd05WXn9l5p3bopuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711137899; c=relaxed/simple;
	bh=TzoXypzT5nop/mD/lYdyor2NleLj34mHEXF5wbURNS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY4OcNwB9KLW11eYuI+hZVHOp2+bpT5ZlsyXkr3+N7sUKA9uRaneVYpYX2tr4trLeEj1hWl+beNB/mBxmPFDXLbWrA1zGv0Rybw1NPEzsnMOenImG9Tx/j+/UsT/URwwHyjfhPsktiHY0M+QQpBNbuKrMGCnw6fEMt0bSaBjEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujJW22Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEE2C433F1;
	Fri, 22 Mar 2024 20:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711137899;
	bh=TzoXypzT5nop/mD/lYdyor2NleLj34mHEXF5wbURNS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujJW22RnBrrMNiPOuTeO38PmnaAgjRDo5amyBHe36+ybGTAQEE7hPBot8y/c1Ce4U
	 1S4QHPa2xszBxmjHp2RnOXJts4YaK3uV+hmc1Gsqy7FzixNJjHnQEBnyjZi4OEVqlN
	 zGg/bo7E8Fpmi5+qYpLKRZXtqC+uNm8Io38mbZf4++qaOu/eU+7lr9HayosRzXE6bn
	 SRkgHPWYIwvsqD/wrURcDo/IaAgDRz/jfftRdg/4hqDldI63fJhjsebkxpbHLDk19b
	 jpALdg/KgWahdoNzZaouMa+3R0YtirrAXl5n3Was1pC7sdSt6W4e+5xK7EAiW3yM/E
	 H7qTKDG8nNuUA==
Date: Fri, 22 Mar 2024 20:04:56 +0000
From: Simon Horman <horms@kernel.org>
To: John Fraker <jfraker@google.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] gve: Add counter adminq_get_ptype_map_cnt to stats
 report
Message-ID: <20240322200456.GB387537@kernel.org>
References: <20240321222020.31032-1-jfraker@google.com>
 <20240322130920.GF372561@kernel.org>
 <CAGH0z2E0Pw1nXueBggqdRhkdJLni+cPMA=dQg_jWQ3nmszu+Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGH0z2E0Pw1nXueBggqdRhkdJLni+cPMA=dQg_jWQ3nmszu+Sg@mail.gmail.com>

On Fri, Mar 22, 2024 at 10:58:43AM -0700, John Fraker wrote:
> On Fri, Mar 22, 2024 at 6:09 AM Simon Horman <horms@kernel.org> wrote:
> 
> > On Thu, Mar 21, 2024 at 03:20:20PM -0700, John Fraker wrote:
> > > This counter counts the number of times get_ptype_map is executed on the
> > > admin queue, and was previously missing from the stats report.
> > >
> > > Fixes: c4b87ac87635 ("gve: Add support for DQO RX PTYPE map")
> > > Signed-off-by: John Fraker <jfraker@google.com>
> >
> > Hi John,
> >
> > I'm fine with this patch but it feels more like an enhancement
> > for net-next than a fix for net.
> >
> > If so, please drop the Fixes tag and repost next week after
> > net-next has reopened.
> >
> 
> 
> Thanks Simon, I wasn't quite sure where the line was for inclusion in net,
> I'll resubmit once the window opens.

Thanks John, I appreciate that it is subjective.

-- 
pw-bot: changes-requested

