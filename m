Return-Path: <netdev+bounces-12343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B1F73722A
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6524F281076
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BF32AB32;
	Tue, 20 Jun 2023 16:56:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564AF2AB20
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AA5C433C8;
	Tue, 20 Jun 2023 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687280215;
	bh=biY/lqBPIIdrqVdz9cSnQ7IyQQi8qtHDX+6spwIMo60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lCfuCMAUgRgQmeCqvi53f0PntSc/j7JCRs61w+bk0rjW3Zhv0isQvzOqTmSPLiXqq
	 w6iUOrvQv1lYNgL6kKLHyd/Fk87JX6MZbSHu/WvfK8fr7H8XOrwaeyo5hCerhcjJ4/
	 GwaHhxpKjB31L/VwbbUyIduV7usPAX+1tqTc3o96nvVDZRVGhLFLYp7kwlRhizgm/X
	 1WM+328hPeheKIsEizro1uQ4ueYH4FtvERnYEGxPoSsqlooKxvwcVrTxe/+Pgypr2S
	 yjpmC9aGQx7WNs9arkt0jl9+PeDiFXwI6Lcy1FwN678a8e3bFAvkT8nj3dssSXnJgg
	 cvCidaHuARyNw==
Date: Tue, 20 Jun 2023 09:56:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org, Michael Chan
 <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next] bnxt_en: Link representors to PCI device
Message-ID: <20230620095654.1050d555@kernel.org>
In-Reply-To: <CAHHeUGWQihg4bTeaCNwq8_1ZxSfL5hpdw-RQOPK6QkSGSdX0OA@mail.gmail.com>
References: <20230620144855.288443-1-ivecera@redhat.com>
	<CAHHeUGWQihg4bTeaCNwq8_1ZxSfL5hpdw-RQOPK6QkSGSdX0OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 22:19:32 +0530 Sriharsha Basavapatna wrote:
> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.

Your emails to the list must not include any legal note of this nature.
I'll have to manually delete your review tag from the system.

