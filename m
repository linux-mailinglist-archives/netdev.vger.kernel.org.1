Return-Path: <netdev+bounces-37744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103EF7B6E67
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 6E6951F20F89
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA0F3AC15;
	Tue,  3 Oct 2023 16:26:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306B38DDF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:26:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3011A6
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696350401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQC0BP7YgGzddk6JoxXZteyIFRUQfQrHXDu0A5yDa1A=;
	b=NOoo/6fJ3170rXdairdt6Xromr2o9TLpP4aTj7JqNwwWw3Lh6bsORkUlz6M5vYu2KT7SVh
	qUhcC1vML/Vu1vDFsxJ7b98afZ8swHtE53l/MS/7bG+ZELVRnBcIz0UkAZftMZKqCaUcFS
	Orc9Ya4C0HVtBKegcHBF63XXPU697jU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-axIciMswN82x03eYOdvY9A-1; Tue, 03 Oct 2023 12:26:40 -0400
X-MC-Unique: axIciMswN82x03eYOdvY9A-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41961124b15so13186731cf.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 09:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350400; x=1696955200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQC0BP7YgGzddk6JoxXZteyIFRUQfQrHXDu0A5yDa1A=;
        b=ko60y1jYCZQzia2qMZF6C/lYsW+EdV+a3SzFWn6QcJ47Ns8j9xZtmZVu1kZafh4H4b
         x9It89V9wO78BpO9LLtZmb2r5dbLTa7noSrFxsZysEWLI4zdFZhSGcpCfhuguLIGDM2+
         F03rC08Z1Ld06P4WDLc4p4lqx9LM2HCoJr6u9862eHMIFeSi+LK4FKa+SeFLr/R0SEig
         FFOZ0rqGD1N6MohcVTuGpPgeeW3mWqGXVgcvbC5wp2LZktnUagg4BMNPl3qsMRXnCrms
         ePeIH1k+vT2spSBFdyIyou76nl9jIa8Eo/42Ym4e8vWY+JYHYv87alIIp+yvirCQ3cQR
         HT0Q==
X-Gm-Message-State: AOJu0Yz0JaR6ruYO5u7onRqYhqX3f2q957RdeZKElQUvpc6BTjfFA5tp
	l8oVV8S2X7XPwnVYQL0G60ZCHOur0gJMzq68Rm7s/G/RaLEfbshbBRScMr8cNx1CfOSg2/6Tzdo
	endXK4ZzAeM3JWaZJsLJwa2UY
X-Received: by 2002:ac8:584b:0:b0:412:1e0a:772a with SMTP id h11-20020ac8584b000000b004121e0a772amr15545997qth.17.1696350399938;
        Tue, 03 Oct 2023 09:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFht7odWq29a5TBcW7tc++EJIJSk2vinTPEHJlpdDK6A2y2BG7b5sXjcJoBiiC5Txm/f/rEtA==
X-Received: by 2002:ac8:584b:0:b0:412:1e0a:772a with SMTP id h11-20020ac8584b000000b004121e0a772amr15545983qth.17.1696350399671;
        Tue, 03 Oct 2023 09:26:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id e13-20020ac8130d000000b004196a813639sm557692qtj.17.2023.10.03.09.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:26:39 -0700 (PDT)
Date: Tue, 3 Oct 2023 18:26:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v2 00/12] vsock/virtio: continue MSG_ZEROCOPY
 support
Message-ID: <4nwo6nd2ihjqsoqnjdjhuucqyc4fhfhxk52q6ulrs6sd2fmf7z@24hi65hbpl4i>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Arseniy,

On Sun, Oct 01, 2023 at 12:02:56AM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset contains second and third parts of another big patchset
>for MSG_ZEROCOPY flag support:
>https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>
>During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>suggested to split it for three parts to simplify review and merging:
>
>1) virtio and vhost updates (for fragged skbs) (merged to net-next, see
>   link below)
>2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>   tx completions) and update for Documentation/. <-- this patchset
>3) Updates for tests and utils. <-- this patchset
>
>Part 1) was merged:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=236f3873b517acfaf949c23bb2d5dec13bfd2da2
>
>Link to v1:
>https://lore.kernel.org/netdev/20230922052428.4005676-1-avkrasnov@salutedevices.com/
>
>Changelog:
> v1 -> v2:
> * Patchset rebased and tested on new HEAD of net-next (see hash above).
> * See per-patch changelog after ---.

Thanks for this new version.
I started to include vsock_uring_test in my test suite and tests are
going well.

I reviewed code patches, I still need to review the tests.
I'll do that by the end of the week, but they looks good!

Thanks,
Stefano


