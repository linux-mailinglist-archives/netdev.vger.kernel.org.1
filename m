Return-Path: <netdev+bounces-141235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 983E49BA21B
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 20:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459931F21887
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 19:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC98613BAF1;
	Sat,  2 Nov 2024 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="IjB2i5kz"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D8191
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730574086; cv=none; b=GuKoQXERgAZEpGTy72qTvFP9msthsJuX+ZoKmvdXAu7baaJ9mRL/VD5RW0G0LjAjHgq9ULFK1g25r7dQFBEADlzQQVsNQwnBU4CnyxERzA4dB5gPbqJF4fkQPE/q0ID2CCaojTggmHWp9sESoWHPz8ooph5VQQy+jskJrfv27E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730574086; c=relaxed/simple;
	bh=3MyrrkeZ+7dujianB0KhJfvGajDD4g01mqZgELSnJZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uuuMU0tXUyACHx2AZXHysLSU+W+3y3n8b/WjOqalFN7Tb9ImF8CyuDSCb5+PVuMiPy3wYvFcGYeYyXS74MDtQjMfghuj6xSPd9JRJAEE2Vly5MH3909a9nL7TDgsK+FnXKYKUIoIOc1VZqasorqvgeBqBSqc/caqD2JeTiwzV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=IjB2i5kz; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=s9a99yU6MnVvj0RHDwRSYgLdzcVA1la4mCyQ0V/UxW0=; b=IjB2i5kzPe4YXowm
	XmxTC9xwUe53AhLJLF4g2PCFLjvT1x1Q5poXEn8F7Rcs5LC4UViAiEC+W1SMQPzFKll4CsJSGHfHb
	UMrXMJSN4CCyx+cXWNIxc8VHOTIMx6ibsRZJHsmpbdbGwv66/BCWmLQKlNZSxOTHGDsEcEx+4wkz6
	EYSNPMTStmkypZ6OyaRCJ6FrBfTNxedrGw6Gzdx2gMnmkaXbTD5jSaWQC9KVjSQqSqdEEXXK6+0Wa
	vKLg6jXE9IG88eoVJmCMwFmoZx+/kPBELQ6nTgZlDSFMdiUmXZOln/IMp2+gAGwI7AQ7XCwWqyoAU
	z03wLctKCaK5qiACjA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t7JNB-00F7Q2-2g;
	Sat, 02 Nov 2024 19:01:21 +0000
Date: Sat, 2 Nov 2024 19:01:21 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: shayagr@amazon.com, akiyano@amazon.com
Cc: darinzon@amazon.com, ndagan@amazon.com, saeedb@amazon.com,
	netdev@vger.kernel.org
Subject: Of ena auto_polling
Message-ID: <ZyZ3AWoocmXY6esd@gallifrey>
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
X-Uptime: 18:58:42 up 178 days,  6:12,  1 user,  load average: 0.01, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,
  I noticed that commit:
commit a4e262cde3cda4491ce666e7c5270954c4d926b9
Author: Sameeh Jubran <sameehj@amazon.com>
Date:   Mon Jun 3 17:43:25 2019 +0300

    net: ena: allow automatic fallback to polling mode

added a 'ena_com_set_admin_auto_polling_mode()' that's unused.
Is that the intention?
Because that then makes me wonder how
admin_queue->auto_polling
gets set, and then if the whole chunk is unused?

Thanks,

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

