Return-Path: <netdev+bounces-17023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD83474FD7C
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CDF1C20EE1
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C927680E;
	Wed, 12 Jul 2023 03:12:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCBB639
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:12:03 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD5710D4
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 20:11:54 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b73b839025so5707303a34.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 20:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689131514; x=1691723514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBzqALDlthuK7btsxeHgDJkZT98lOJZGXujndPp54/8=;
        b=fiIgyjLn/rESnh74FBMYuwIsNIWxMFu6kSoQjGK69vO2LfikoHuYJ/GDsLYN9NUTFy
         tzW2PtLkRD/96r4nMAOjtV4a6yt8JOsUmSoqNAdeWocDLTQ7gNd3SCr+4ZDTI97fTziQ
         ZVuQxjUInn5SMzB5vA/UtVfhKNkyou3n8ln1p0Kz6bVMMLz+q3JoPHgjYjHWodfkMtIV
         Ljvn273pTSOQB/UlWwJqHclZkWoXuW+qcweQQDi/7UuHb4dOuWivzyJOxtPbmA9/A7OM
         QDrMyQ+RKw2VZF9ONNcf13NpzXA1agoBEuVKW7Zp7gSz8HO54HJpt8K92BJTs03wcAY4
         CaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689131514; x=1691723514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBzqALDlthuK7btsxeHgDJkZT98lOJZGXujndPp54/8=;
        b=YZqW4Nxv1Cq4xXEjrWiy59YsMQ/joQ3r+tdlyPEEGmPoPkp6GhXzZ65p8b1kHpVnfl
         KB2rdjMhnfNVTATsg9cQnj07utgdABAwAdG++huzJOmyKPgjs+bPXrb5IOE3f2u7MF0x
         nzGCU7KlNiwNRB1IB+mxLwgS0n9R0LuDXo4ouNladL2Vn0z+MqPVfhv1dJe1iKnmPlF4
         SnMvxlM2vtXTsUregiu8wHtz+dYovnKzsB1+zB4673nZb5VWKnGbjQXidR5a3fY/mrJ0
         ED1SsJY4L+7ARl3azAXB5P6j+voa361kCudfVIpftimppi1fNkq4gpNVqi42ltsVQni6
         pKLA==
X-Gm-Message-State: ABy/qLb0ZISZtAqnEkP/IvDzJM0d4+Yy4IJJNaTDIJN37Vo4m9UZSQ9b
	c5fUw0tTaAFtTyFN6JO0j9A=
X-Google-Smtp-Source: APBJJlHko4pQzrXi9LJDqvFV5XMrJ3nc1PlCNSqIiwsj4t8mWGA0Zae5zVrDQWKwxC3e6dM7RJBXEA==
X-Received: by 2002:a05:6358:9910:b0:135:4003:784a with SMTP id w16-20020a056358991000b001354003784amr15266228rwa.19.1689131513597;
        Tue, 11 Jul 2023 20:11:53 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7829:4ce0:2824:2fe6:d3e1:6539])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902b71000b001b87bedcc6fsm2684761pls.93.2023.07.11.20.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 20:11:52 -0700 (PDT)
Date: Wed, 12 Jul 2023 11:11:46 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Andrea Claudi <aclaudi@redhat.com>, Ying Xu <yinxu@redhat.com>
Subject: Re: [PATCH iproute2] lib: move rtnl_echo_talk from libnetlink to
 utils
Message-ID: <ZK4Z8j7hFHcjWv1i@Laptop-X1>
References: <20230711073117.1105575-1-liuhangbin@gmail.com>
 <20230711090011.4e4c4fec@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711090011.4e4c4fec@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 09:00:11AM -0700, Stephen Hemminger wrote:
> On Tue, 11 Jul 2023 15:31:17 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> > In commit 6c09257f1bf6 ("rtnetlink: add new function rtnl_echo_talk()"),
> > some json obj functions were exported in libnetlink. Which cause build
> > error like:
> >     /usr/bin/ld: /tmp/cc6YaGBM.o: in function `rtnl_echo_talk':
> >     libnetlink.c:(.text+0x25bd): undefined reference to `new_json_obj'
> >     /usr/bin/ld: libnetlink.c:(.text+0x25c7): undefined reference to `open_json_object'
> >     /usr/bin/ld: libnetlink.c:(.text+0x25e3): undefined reference to `close_json_object'
> >     /usr/bin/ld: libnetlink.c:(.text+0x25e8): undefined reference to `delete_json_obj'
> >     collect2: error: ld returned 1 exit status
> > 
> > Commit 6d68d7f85d8a ("testsuite: fix build failure") only fixed this issue
> > for iproute building. But if other applications include the libnetlink.a,
> > they still have this problem, because libutil.a is not exported to the
> > LDLIBS. So let's move the rtnl_echo_talk() from libnetlink.c to utils.c
> > to avoid this issue.
> > 
> > After the fix, we can also remove the update by c0a06885b944 ("testsuite: fix
> > testsuite build failure when iproute build without libcap-devel").
> > 
> > Reported-by: Ying Xu <yinxu@redhat.com>
> > Fixes: 6c09257f1bf6 ("rtnetlink: add new function rtnl_echo_talk()")
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> I don't see this when iproute2 is built.

Yes, because commit 6d68d7f85d8a fixed this for iproute2.

> Libnetlink is not a public API. And there is no guarantee about

OK..

> compatibility if an application links with it.  Collect2 should be
> using a supported library like libmnl instea.

It's not about compatibility. If an application linked with netlink.a, the
build will failed. e.g. 

# cat test.c
#include <libnetlink.h>

int main()
{
        struct rtnl_handle rth = { .dump = 123456, };

        rtnl_close(&rth);

        return 0;
}
# cc test.c -lnetlink -lmnl
/usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/11/../../../../lib64/libnetlink.a(libnetlink.o): in function `rtnl_echo_talk':
(.text[.text.group]+0x1f78): undefined reference to `new_json_obj'
/usr/bin/ld: (.text[.text.group]+0x1f7f): undefined reference to `open_json_object'
/usr/bin/ld: (.text[.text.group]+0x1f94): undefined reference to `close_json_object'
/usr/bin/ld: (.text[.text.group]+0x1f99): undefined reference to `delete_json_obj'
collect2: error: ld returned 1 exit status

Thanks
Hangbin

