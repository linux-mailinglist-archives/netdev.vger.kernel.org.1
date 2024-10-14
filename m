Return-Path: <netdev+bounces-135166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2C99C8AC
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95161C23EB1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C947419E7D1;
	Mon, 14 Oct 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="c3bBTXju"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA6132117;
	Mon, 14 Oct 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904912; cv=none; b=Z1Yj2Ny2oqMNpXeFu50YpMzZ/ELZSoHL4j476PVgSzmrrGe0VEwnXmD5MCEowXqhkYpxntxnLG+1gaLqkHu20T4YKNxB6zoEta7urBM42RrTdZuAw3BkKbzuAW6cr8wrt2xhKX6VI3sn+HrZU7mBNK8XRueZ7QOOu5xQyG4g+Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904912; c=relaxed/simple;
	bh=ZNQYRIEmk/lju1nyZHTRwtQrL5EYRur5h4ZyCbkLyuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmueMqR3TbaGosoPGZ4vGh/h3npANnecjQl5qRZ6L0/Zj7+gn8+uBpHV/umuRdeN9o7PB20KlnLGQEOd+QEIuuEfB9G4baU5ryCaLord7gU1bevdpygW6k5sQh/iz1pEpeAm7Y/xO0ltafr/NaFTJcECG49UFX91ttq90jGslAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=c3bBTXju; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=fn2nhf87gTq2oHaVPE2gcpSItaLT3pbBztPNWjpj9qc=; b=c3bBTXjuJ9E5EBkc
	ss3rw2YQ1//oumNx3PqxBufKcxs6gykxsHEmd3UnvESJp/tP3aq0X82u1KuHPm9lX+/khPpmAFAz6
	ResAnMVXLewWqgZ0vCKtPSXfWtk8lfZqo0zYre4Z8m3g+fKmIgcxk4EcI65jZktS6FoHvCj/LWgNG
	qfzo4zotcw5SxJGwoNgiehOt623BaRE2/sBhmmxsYO9GUChk8hxVL3/cROrYEWBAsj45jmakMSsvL
	WsvCxUFMihgz+0W9Km809cQQgQlfjFF1P9C3WNA9Blssr18yjkf4p6+JKNC0g4M28X0CmkP4V66FA
	CcptP0qp/AoZ6R4ujA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t0J8d-00AvNF-28;
	Mon, 14 Oct 2024 11:21:23 +0000
Date: Mon, 14 Oct 2024 11:21:23 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: bharat@chelsio.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] cxgb4: Remove unused t4_free_ofld_rxqs
Message-ID: <Zwz-syySKseMi5ZE@gallifrey>
References: <20241013203831.88051-1-linux@treblig.org>
 <20241013203831.88051-7-linux@treblig.org>
 <CAH-L+nP8LaWnhHwntqgY6+pfH2ouPHQ-J5uUhyjVL1T2spB2VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nP8LaWnhHwntqgY6+pfH2ouPHQ-J5uUhyjVL1T2spB2VQ@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:21:02 up 158 days, 22:35,  1 user,  load average: 0.09, 0.04,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Kalesh Anakkur Purayil (kalesh-anakkur.purayil@broadcom.com) wrote:
> On Mon, Oct 14, 2024 at 2:10 AM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > t4_free_ofld_rxqs() has been unused since
> > commit 0fbc81b3ad51 ("chcr/cxgb4i/cxgbit/RDMA/cxgb4: Allocate resources
> > dynamically for all cxgb4 ULD's")
> >
> > Remove it.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Thanks for the quick reviews!

Dave

> 
> -- 
> Regards,
> Kalesh A P


-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

