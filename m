Return-Path: <netdev+bounces-62937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D2829F16
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 18:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4671F274F6
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594E44D112;
	Wed, 10 Jan 2024 17:25:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79E4CE12;
	Wed, 10 Jan 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoffel.org
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id 17DD91E12E;
	Wed, 10 Jan 2024 12:25:07 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id A9991A8E30; Wed, 10 Jan 2024 12:25:06 -0500 (EST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26014.54002.663705.978220@quad.stoffel.home>
Date: Wed, 10 Jan 2024 12:25:06 -0500
From: "John Stoffel" <john@stoffel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
    Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>,
    Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org,
    netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] netfs: Don't use certain internal folio_*() functions
In-Reply-To: <20240109180117.1669008-2-dhowells@redhat.com>
References: <20240109180117.1669008-1-dhowells@redhat.com>
	<20240109180117.1669008-2-dhowells@redhat.com>
X-Mailer: VM 8.2.0b under 28.2 (x86_64-pc-linux-gnu)

>>>>> "David" == David Howells <dhowells@redhat.com> writes:

> Filesystems should not be using folio->index not folio_index(folio)
                     ^^^

I think you have an extra 'not' in all four patch comments. 

> and folio-> mapping, not folio_mapping() or folio_file_mapping() in
> filesystem code.

