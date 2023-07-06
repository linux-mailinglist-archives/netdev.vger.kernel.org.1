Return-Path: <netdev+bounces-15807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A794D749E7D
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B4328127E
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAB7945A;
	Thu,  6 Jul 2023 14:04:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5A9440
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 14:04:10 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD71FED
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 07:03:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-656bc570a05so152188b3a.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688652235; x=1691244235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhSDI9mp0MYKeqY0tJX7SergTVTmGv0F/ckbyNmGNLQ=;
        b=FMqh2CmzOm6XDjJjezWBlN875lQ5T+a7DnklQNymtU9D+p4Vamdg/lVJcXx5LK9wQB
         KMF3m7xyChwczs3gSrW0hfYLg6AHUOPg2tw1QHIcglCDiKzSYTOIQrtnMYep6XtsjIep
         DxJJ6tEz23KWKTCsBzXv4e2DMZK0tudoGmt64Vn23mE4w14gdIX8FajdCS/c+EBdj4BM
         OLhNcMy3ZYtdTw3gnyRZjxn7tMXpguxXzPohD9RzlAV02/2dZlziCIX9IP1zVTQgKS/1
         HI6e6TX7bpBdHRlpwO53EfTwR3UPufykmkpeAJRybBh5mzEiKnBBl2q/GqPD8Ytlw/Gs
         lsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688652235; x=1691244235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhSDI9mp0MYKeqY0tJX7SergTVTmGv0F/ckbyNmGNLQ=;
        b=jn2Z8/DH/ahZ0co3bMCH7KmC1O7VvJ5G9cuXWDclGawUf9vpOXia2it90vVNZS+MM+
         IoEBFvQPLHbMIr8m3ucSrtSJ85VRsVmr9mFVU5xpnZQO5Tp1AfUHxSxKcYNHc3zIQVkz
         SM4Fdr4U532RUmdaGnKY/tyzOFrgCyvyCDBoDQBj3EibHTl0cQhq0CRTG9mJK7MCoy0o
         +y7PqQJ10XfD1d6cPZuta1d8OZ9a27L3K7TVCvaMzkBusSP/rA6g6FLjuBkDDJHP1jeM
         MYtxKhbqukoF3Cq1LufhKWuZ+o6tEjTJV809g7hJOOXkoHJ/ZljrRzBLI0X1A96zB+xr
         aHCw==
X-Gm-Message-State: ABy/qLamllIcBeNPBxXJN27F7tpbBaTdPJGbJrmpn9eDDaYj3BoL/5Du
	q23KZJCzHfIqXW5/wRF4HhdSAA==
X-Google-Smtp-Source: APBJJlHWx70FxXddJLp/svv44qJ/lHFgMni3NpkbFoqzcjvrqGi64yR8YRM3ydyDuI4xKaOrlEAb7Q==
X-Received: by 2002:a05:6a20:7495:b0:12d:2abe:549a with SMTP id p21-20020a056a20749500b0012d2abe549amr2182854pzd.6.1688652234613;
        Thu, 06 Jul 2023 07:03:54 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z21-20020aa791d5000000b0063b898b3502sm1322987pfa.153.2023.07.06.07.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 07:03:53 -0700 (PDT)
Message-ID: <ec9b55b5-c64c-3ea4-9f39-128cd2e0a8ac@kernel.dk>
Date: Thu, 6 Jul 2023 08:03:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Fix max/min warnings in virtio_net, amd/display, and
 io_uring
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Yang Rong <yangrong@vivo.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Max Tseng <Max.Tseng@amd.com>, Josip Pavic <Josip.Pavic@amd.com>,
 Cruise Hung <cruise.hung@amd.com>,
 "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 "open list:IO_URING" <io-uring@vger.kernel.org>, opensource.kernel@vivo.com,
 luhongfei@vivo.com
References: <20230706021102.2066-1-yangrong@vivo.com>
 <CADnq5_MSkJf=-QMPYNQp03=6mbb+OEHnPFW0=WKiS0VMc6ricQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADnq5_MSkJf=-QMPYNQp03=6mbb+OEHnPFW0=WKiS0VMc6ricQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/6/23 7:58?AM, Alex Deucher wrote:
> On Thu, Jul 6, 2023 at 3:37?AM Yang Rong <yangrong@vivo.com> wrote:
>>
>> The files drivers/net/virtio_net.c, drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c, and io_uring/io_uring.c were modified to fix warnings.
>> Specifically, the opportunities for max() and min() were utilized to address the warnings.
> 
> Please split this into 3 patches, one for each component.

Don't bother with the io_uring one, code is far more readable as-is.

-- 
Jens Axboe


