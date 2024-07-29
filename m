Return-Path: <netdev+bounces-113687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E74993F915
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BC2280F2D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F61158D8F;
	Mon, 29 Jul 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuLNC8tq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3F158D6A;
	Mon, 29 Jul 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265617; cv=none; b=qzAYkJqMlnVgihqr21Tnl8lRKW+0uCg3QhLKVblqXrRI6hZ/jpVuwYYOzXZyzfgSzP+71tcpQO0J5GA+9XQtasoNYRltuUzltZM4Dfx5wDji7WkW21/u+t12kRnv2fc8mSF+yumKIt1hOMAfdGa3aHgrfPmxGqDUewtcDPr5pZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265617; c=relaxed/simple;
	bh=T4nnuqWVIW27yTfNfQJScA/1tolP2H3cGTgugfKlzow=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=NGW880LUsHFeua2pvwdHlcXxdyxu3ioubbPR2Vpr48hondOCq+AR1UqxsZcYHDT3WdUSX3saFp4R5adZA0FErPOKKlDGHKGYZ2VOAH5O13jeSvzxjReTmLAODEXMk4e6G2EBgr9roe24u5sB6kcaSqcJxJNYiOPqbYgQqiru2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuLNC8tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8155AC32786;
	Mon, 29 Jul 2024 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722265617;
	bh=T4nnuqWVIW27yTfNfQJScA/1tolP2H3cGTgugfKlzow=;
	h=Date:From:To:Subject:From;
	b=kuLNC8tqakpL5loMHpUu97zrugDZOGTLnfQ7Nf0f35mO5dXIt8libHFk2PjendPsu
	 evzKHIaEfis7gt5R/l8No41iQyHbhLLWk7O6rFJayIKKbyJSEckFa8Nqwl9wQ3fUP/
	 iMem08453e+d1LQrkvS3MJocMUGEaaVGAFiTuFn12JRxj/qkQvc1Il9FmJKmorRr9C
	 15h8eaATsBoTarDRTDAww8E6bD0AvKiamWP7xlkaXd02qasYKkRRN/GuOLG0of+mD2
	 QsG0Xx3csL8oK/9Jc/xHphKGVhsD1EUZUCGssd0vSQoI0Oir3Pms7aJa+bxpjL0Ayr
	 Qo5xeH8xxYjaQ==
Date: Mon, 29 Jul 2024 08:06:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Jul 30th
Message-ID: <20240729080656.3e8ae8de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

No agenda, yet, feel free to suggest topics for discussion.

In terms of review rotation - it's Intel's week.

