Return-Path: <netdev+bounces-169262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B51A43264
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3EE3AC1C4
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 01:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09CB17BBF;
	Tue, 25 Feb 2025 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="LoOKZyl6"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643755897
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446486; cv=none; b=ZwfrKP4VsOACCKWGsx0bgsd/0RTWSCVDX8+/fSB3SI8pwKzFc/t+2MfUANgEsnz3Pkr54G7VqYibR/gk4WbFBNHebAJOGlXzOOTExB4/DjHuXtnpbHtMtllAgkwWR4Ne+4quaBtravOl+z/Oq81x4Amggm7tLWPKW6iSuwKDWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446486; c=relaxed/simple;
	bh=GG46MT6hBee/UooNnUiSqqJXu7IIFVXuBLyi39J1W3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fwY/xADMR/tByYX36NXLRAksxMWuTMCLSN9OYNl+AIl97jpyEOQSUDnQvadEyAckv68+Z0SdSWIw4uyez3Is8Pdl/os92E2KbBehTP6PH/wm5l4fLGTMF/61O3ERXe6Yl+1SBixqpD532rcE8P2KRLh0//nY3TAQvQyL0twB1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=LoOKZyl6; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=MV74ljUXg6YHwtAIeBCIEjiOkWhFUxNyCvjMQTCtkW0=; b=LoOKZyl60ufb33qO
	awJ084b0OO7Rz+e92o9R/gWp9t9EqPQHUJyec5tldT6ecnEH9d/17IYyJ1PPJ4bQ5s0+FhesieZUg
	Spak/3fvyHutZzVazIdMlJ+zr2KLfXstbfb+ouw5H7rOpEz5su5wLgdv7Ds40l/vGq0DjG+DPeJ7M
	W3CVPm7eAIzJh3mkSbYNxts81sTXDaFDENeuwj4wzPJ6y04zzBeqd6AFzCWzS5DU8BNEqXIWHSvWR
	wiF0d2dD0lUFF/iKY5tooGviCmovq0ScUXgEhPE5op0ax+iqcG15L0FCIMi/inZO9bWurkKbTD/Bu
	AcbO6SDhqhd7TXNaeA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tmjdS-000Yn0-1L;
	Tue, 25 Feb 2025 01:21:22 +0000
Date: Tue, 25 Feb 2025 01:21:22 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: srasheed@marvell.com, vburru@marvell.com, sedara@marvell.com,
	sburla@marvell.com
Cc: netdev@vger.kernel.org
Subject: a left over octep_vf_wq
Message-ID: <Z70bEoTKyeBau52q@gallifrey>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 01:18:07 up 292 days, 12:32,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi Shinas et al,
  I noticed the unused work queue:

drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c:21
   struct workqueue_struct *octep_vf_wq;

It comes from last years:
cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")

I see some discussion on the list which looks like you came to the
conclusion not to use that queue, but it looks like it didn't want to leave.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

