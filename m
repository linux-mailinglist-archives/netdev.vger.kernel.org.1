Return-Path: <netdev+bounces-33203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D474679D052
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E640281C28
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023D6168AA;
	Tue, 12 Sep 2023 11:47:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D759443
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:47:12 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B4B10D5
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:47:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B8381FD77;
	Tue, 12 Sep 2023 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694519198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNx29bnJ99NS09aFxiAeMZMQZbsfMZR+hkX0zVZ1siw=;
	b=Tk87M2n+BYaPsG3xv2afWFOtpMwJ+cLBD6B026z0l7ZBFD+fp/3KeO+usGpjhaG5QChYRN
	svrGkP8nSmBJjWxcpl0Ngm3fxTKwZqWtjvJzT03MBZ4fzr8CH+V5yAAkT9OfORc6tqgz4/
	Oy2jPt8DWA5fxxfb0BMBnxBHvGJlGEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694519198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNx29bnJ99NS09aFxiAeMZMQZbsfMZR+hkX0zVZ1siw=;
	b=IMsLIb8j8m8o12Z7Yu8RG4KZHkfNUOdNrfXDnvp1okE5HSdwM+f4bljGccLxguXL1bMIQc
	iWXNW+HCrEVOUMDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16B29139DB;
	Tue, 12 Sep 2023 11:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 60wtBZ5PAGX/fgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 12 Sep 2023 11:46:38 +0000
Message-ID: <750247cc-11a6-4383-980c-de72638fbe79@suse.de>
Date: Tue, 12 Sep 2023 13:46:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 00/18] nvme: In-kernel TLS support for TCP
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230824143925.9098-1-hare@suse.de>
 <683554de-5f4f-4adb-4e97-c532f514b352@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <683554de-5f4f-4adb-4e97-c532f514b352@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/23 13:34, Sagi Grimberg wrote:
> 
>> Hi all,
> 
> Hannes, I think that this is in decent shape. Assuming that
> the recent reports on the tls tests are resolved, I think this
> is ready for inclusion.
> 
Thanks for that.

> I also want to give it some time on the nvme tree.
> 
I guess that will be a good idea.
I had a look at the report for I/O timeouts with TLS, and currently
it seems not to be TLS specific but rather generic issues with the NVMe 
stack, just being visible now due to delayed timing.

Cheers,

Hannes


