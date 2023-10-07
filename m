Return-Path: <netdev+bounces-38734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B4F7BC4AF
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 06:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C0F281F67
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 04:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BC039D;
	Sat,  7 Oct 2023 04:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2QmNI90"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF615B5
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 04:33:13 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5D7BD
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 21:33:11 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59f4bc88f9fso32452997b3.2
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 21:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696653191; x=1697257991; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXf8U8C79vuohVnXvifYnSGTERWziOzTJ9tH/XzO64c=;
        b=G2QmNI90irCvCjWIWnb1O8LJCTN2BOv7ERI/hBa0JI6wuHJTlShGtxUeitJ3doYBHL
         S0vbiyldUBj0D2oT30PloiF47sz3aWzd6RsODBaEo0D5/xXwzw7Fx5P3XLs4A7so1sYn
         qO6hlZdVEj6s8m5DRe/HElUXohTv4ltysDA+WD8oSZDNE5FabyPInoGNug9NecLS0kzn
         J91Gbjp4ylwuOe3L/1BRLFj+TG0j60JyFELC5WfAQuKw/3sdllANgDaKI9D3c1hyZmir
         I6HKWZE/+6fjdHhlcTo2O2HbQI24aZvPE78sd+58Wq5tmkBPhN5d7QzOhLHsfa7Uyi+w
         IpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696653191; x=1697257991;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXf8U8C79vuohVnXvifYnSGTERWziOzTJ9tH/XzO64c=;
        b=DDSIqMP/7iLnrdi5JrFUJeDXr6iRxm/3Q/YgZ54db7WOLwx5Z5Gc8b+ZjwkURpfwaA
         OZEaMjJRreR/Za7bBUsyz5OarUZ/h11qhOxiHEoZTWWklQyL7Aw3QJ+FTknht9ek8PMC
         vbTQiyBoK2ME/Q3CfYWMs0HzSM+X7YCRmIkp6z+cBNNvyEwXhpl5lSJZ2OzyzFYA6FpQ
         9MSFiC3HdMvRjw6RxAQBqQWw+c+w8gIljMRAsSDadFXGBSkUk62l4s3aqt1oMUA/yHCp
         Qaj1Omuj8JE6VnyBfanwXlVv92V2inknWMYKOSKyZMDmPnVhqz7+EXFlVTucLE7BCX17
         AG/g==
X-Gm-Message-State: AOJu0YxOY3g5OPlCPAQArQs2xmim3pRDy7U3s/V3B8cwevxyWBvSxpNQ
	xRnuEWMc5JovWKewfxXhojCX6A==
X-Google-Smtp-Source: AGHT+IGTpv8UvjCyOJzS3L3dtxDOz63ebkoFEikvvBO0NxbbM/Dn1NW+bTCtHist3Wz9lX81T/YdLw==
X-Received: by 2002:a0d:d641:0:b0:59f:4ee0:26e8 with SMTP id y62-20020a0dd641000000b0059f4ee026e8mr10164738ywd.21.1696653190770;
        Fri, 06 Oct 2023 21:33:10 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n16-20020a819c50000000b0057a8de72338sm1770078ywa.68.2023.10.06.21.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 21:33:09 -0700 (PDT)
Date: Fri, 6 Oct 2023 21:32:59 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: David Howells <dhowells@redhat.com>
cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
    Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
    Christian Brauner <christian@brauner.io>, 
    David Laight <David.Laight@aculab.com>, 
    Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
    linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
    linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH next] iov_iter: fix copy_page_from_iter_atomic()
In-Reply-To: <1809398.1696238751@warthog.procyon.org.uk>
Message-ID: <356ef449-44bf-539f-76c0-7fe9c6e713bb@google.com>
References: <20230925120309.1731676-9-dhowells@redhat.com> <20230925120309.1731676-1-dhowells@redhat.com> <1809398.1696238751@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[PATCH next] iov_iter: fix copy_page_from_iter_atomic()

Trying to test tmpfs on latest linux-next, copying and building kernel
trees, huge pages, and swapping while swapping off involved: lots of
cp: error writing '/tmp/2624/Documentation/fb/vesafb.txt': Bad address
cp: error writing '/tmp/2624/arch/mips/math-emu/dp_fsp.c': Bad address
etc.

Bisection leads to next-20231006's 376fdc4552f1 ("iov_iter:
Don't deal with iter->copy_mc in memcpy_from_iter_mc()") from vfs.git.
The tweak below makes it healthy again: please feel free to fold in.

Signed-off-by: Hugh Dickins <hughd@google.com>

--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -497,7 +497,7 @@ size_t copy_page_from_iter_atomic(struct
 		}
 
 		p = kmap_atomic(page) + offset;
-		__copy_from_iter(p, n, i);
+		n = __copy_from_iter(p, n, i);
 		kunmap_atomic(p);
 		copied += n;
 		offset += n;

