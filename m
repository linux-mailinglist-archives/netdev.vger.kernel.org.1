Return-Path: <netdev+bounces-29148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE55781BB4
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 02:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C461C208C4
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 00:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C444627;
	Sun, 20 Aug 2023 00:28:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80964173
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 00:28:55 +0000 (UTC)
Received: from sonic314-20.consmr.mail.gq1.yahoo.com (sonic314-20.consmr.mail.gq1.yahoo.com [98.137.69.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F67381C3
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1692485452; bh=1al6UIUGjAWijEREY0tN7kOCM87Jx8xq7dRizWUCdNQ=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=Dz3C3K7oZo6f+Bf+p/vqMbnB5kW9b7m9e1xfQ80R5vECGiMq0f5OIGbsTf2j9sFx7i6ix3Bu/RzRoYTsZ1274KzmxCnOQ/Laj8Nai+YvlG8sVtX6uUWq0FN3QVMzmyCEEeBurXoDfBuvEVbmTOFwVp9HuE3gjl5cCBkuJGwdYhSboNqC3HdQNDwPRte/gUBY2tlo6D9ZyxHftINAW/QYXHk5NLI6g2qJ1grXvv/jlj4ovbBxQOmLMGl2/lV2kGpUTd4ng15AzMeBllFJviFNdiIyc1fqJpuzO1KJWeROxUsN9W/cf71BchN3wEJFHPWjkA1F73TGza7GyZcLTVbIzw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1692485452; bh=hMTDvzJKfvKZLGVCZJouP1qfgxLwMoRwU4VVHBiMUaP=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=cn93gOQpy6UkO7RYfz8Nzgod+mP2xSy6pbq8BGnlbXDXzI/X6oJ7eSBsW7cm1paxvPd1iPXVtL8pe6zzw2AwwAxhWlF+LYo3GrNrxpiW48oNP0a76fV+lX60/P1xqHt4+b7MWtlwHaBW8ByVB4UgrXQhwVuVMeUILeSIYJ11cFRarIPB5WoKbFqrURHAuJUgJhni6SG4XZYpnA7VCvRoFEd6g2KvWxZIhhDpRwY8h1AGkN/x8bdNaZ2DJH2+JM2xMgB8Z4Oe5q/8e5FIqeztDsoRlSX3rtPeyiJZRKKCjk6xMOYk8pOvDB2cOj9vI0CQt/To4UlmgsJK8rO+/DFbkg==
X-YMail-OSG: zUXvuGkVM1lXb.uKGnirb8.pcDvq21VAbkvr5u0mGTTJa52FjNiwDME580CpMTs
 QaLZM50VH_582c82IlLmPXwVUQGsbB6759xKbsXfh.4rjvgaTTvLkoyj5j1kvN_Em3CGNGdrDLW_
 s4Zwlb_6pVL7kVkPVRskvBFvPwwL4sVdrhred44KOPraHl5YUXRTqZ94jjsVsVvXy41FucVGoZ2F
 f4sYrVlos6z1E.S3GqBbxMJjWU3etcFVI3hMXwv0e3z6vXqzcn3USrFz1JgCCCmnygGMxKVXLMin
 1hKS_h0f6km.5K5bFokglCvmJxEVgQ96eds7NnG4UxTKgWzfJuXAR9vnUbxsebnWwsWcf1vCMD44
 SJGzRw2yoBNlWmCyvCRvQnxn2tH8jnabiIakDHYq_ZiC_9FT7vD62DUMMlWOiFRxuZr7GrUhzJxK
 ZZHPNfLMUMQl2FlWtR4MN3BTLr6MB_0ysWzlaeBA2eilNzAfcSekfl07Z9p48Y_lVfbJyDIUdWqP
 SpHKMQQLeYHA4EoDDhQa5LecWJDxT9Fu6_QQrOcbuAu0R9VLtgFMbqyIDkoHMXPTpRl.aZ8Ap_Vp
 BgC_np2.6DQnjfWbj7LRNBU_dXloMPBBGuEd0UUUDLQW.CiSbj_uo8Dp9S5vkyljDt1PdUiSqpA4
 Q2yiAmgZhwTcxNi8yLDIbRxK1ARmuzhBN8KsaehK8VnJ4.eSqzpNjQSgvRO3AL.VDyOqwYFZ6YzE
 88wca7oTvfR1dZXISovcsTJH9CBlP1W7G0ytgt6eTBgKCs3.Fvpxip7OLwo1Uafl7N8WoWMLFu2S
 xGwqSxlnSD.LmtAHQTays2J..rAdOCV8TysKxUWWRI7AePdzSszcJi7wneeNcSVTVnkxZVC0_DgF
 _42wwoibHIvpKB.vg.kuXVUlLdaMLVoSCRjZqAFbmVYF865LT3ovOgZsMjAhHbuvGG.UbUEeJDVE
 QsQ0baUP8tjWzr.gspLQ0JIxw_eu4.0HvDVLs3rXgWvKSYjt0FhAD9kSy6B0pO5qyo421i64IG00
 48U9NnbfBhQpwWtuszbgw0knwxoUqn5mYdL3v05izlXnxnPt_FMezV.72PKwXYWgXGQ_bHgG1h.Y
 bXmvg8cUeAJRQA_uLeigcub1fS7NeQ2LvTPj6NIPsljt7IJSTuo77yJ.2eyn9CQAKs0Avjdn0gQX
 yBtD5NGekd5dHPxHJJHqjxF7Ch_2FpGt.qPHd5EMNDEZJ0yYBDcFgpjKgG60OnKWTxl_lkbRY.fR
 8L3kCGWwJSrgMAGNhEg_ijf5W.lZutvF9DBmKKsWv7bOIwIe87ZhVLmeSiIp3yvwgpd1m99xed_c
 O_KsgvdvljDBtxqdchjMnHraELy7L3FAZgwoPKwkxPIKCQmeaqx_rhkvpQAZASJE0jnVSID.qsNf
 tcJezMHqbxfqdmm1jHzejBilakFL4lv6BRaZBOXhCoqt.WbLdYsovJGDt9RNa_xm0fZUK0T6w8Wg
 6AImSjTasItwLnuLg8l9sfco6WMlxfu7u6pzX3726BihxF5nesNVtIkcofDThh0gQJIGvWnHy_lL
 F_4mO0yEw.ue_Pn7V2sfcizZ0ki1whiY76VRok5AkKF1VSs3rv2P4cb0KZ0MuIqZxd9qonegDZPA
 .2w3.SbC3P3bAlp35j0HtVwlBHYFfzj5XizgEVCM57GURxafsWRwGAY2OXhSIs2Bm2hrg_XpfvfT
 _J3SEwGvE0tsFATwE5IFm3eQbpHsCHuA8wX91ng7bbrCMPw60NuSNDhWP68PbTpHBgL40rwYseW7
 5_DNoLDfc1Hzbt0UiRUbaIX20rkPm15nHY_Ij7t_hDDwM70Du0LKlWW9qC9EnSUxGrG8xjihdjtD
 Gb3qyOYTUkSIbMaYmk9QoHx8Ed6FBhJuxEioaHA2QA5qojyYoql6qlCfbSzHgPrdICgx9BefC_7g
 NKm_HVppLFdY0K637hR.LYCzzmZfc2eiRHjsSGC.wSBBB0v1MS40Dl0XfbkN8qn.yYbqZZhWGFfl
 dnATqDD091hHW4YjwMy2QEoFlIuU9u5ttL9w42hRBvh_xdw7eq6hgsPVtQDjkJG5KF2G99smhPg8
 Pz3FaH_vnp_oKJCkkx2cQB9NFYcLefIkLjRuP8WUiy2VnEwyjC4xybeAI4lEBiASv2Rkb74J0V0j
 yphDqV1zW._IMH0S85A0e6XLtMHNDHcRVOjba1aV1OzljWZ60YRk9pXoJaR96h.AeyMpyK8_Wdcr
 yqAi6V5xlNeAKx_J0e.b2s04Zw7ZMsvr1Fp8-
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: 6d1d65d1-db0a-4a5b-881b-11f6e95c97f5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sat, 19 Aug 2023 22:50:52 +0000
Received: by hermes--production-gq1-6b7c87dcf5-fl46l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f384c2cb59da2702428e5b9e0ae9f72a;
          Sat, 19 Aug 2023 22:50:52 +0000 (UTC)
Date: Sat, 19 Aug 2023 15:50:48 -0700
From: Ziqi Zhao <astrajoan@yahoo.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: arnd@arndb.de, bridge@lists.linux-foundation.org, davem@davemloft.net,
	edumazet@google.com, f.fainelli@gmail.com, ivan.orlov0322@gmail.com,
	keescook@chromium.org, kuba@kernel.org, hkallweit1@gmail.com,
	mudongliangabcd@gmail.com, nikolay@nvidia.com, pabeni@redhat.com,
	roopa@nvidia.com, skhan@linuxfoundation.org,
	syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
	vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net: bridge: Fix refcnt issues in dev_ioctl
Message-ID: <20230819225048.dxxzv47fo64g24qx@Astras-Ubuntu>
References: <00000000000051197705fdbc7e54@google.com>
 <20230819081057.330728-1-astrajoan@yahoo.com>
 <df28eac7-ee6e-431c-acee-36a1c29a4ae0@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df28eac7-ee6e-431c-acee-36a1c29a4ae0@blackwall.org>
X-Mailer: WebService/1.1.21732 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 12:25:15PM +0300, Nikolay Aleksandrov wrote:
Hi Nik,

Thank you so much for reviewing the patch and getting back to me!

> IIRC there was no bug, it was a false-positive. The reference is held a bit
> longer but then released, so the device is deleted later.

> If you reproduced it, is the device later removed or is it really stuck?

I ran the reproducer again without the patch and it seems you are
correct. It was trying to create a very short-lived bridge, then delete
it immediately in the next call. The device in question "wpan4" never
showed up when I polled with `ip link` in the VM, so I'd say it did not
get stuck.

> How would it leak a reference, could you elaborate?
> The reference is always taken and always released after the call.

This was where I got a bit confused too. The system had a timeout of
140 seconds for the unregister_netdevice check. If the bridge in
question was created and deleted repeatedly, the warning would indeed
not be an actual reference leak. But how could its reference show up
after 140 seconds if the bridge's creation and deletion were all within
a couple of milliseconds?

So I let the system run for a bit longer with the reproducer, and after
~200 seconds, the kernel crashed and complained that some tasks had
been waiting for too long (more than 143 seconds) trying to get hold of
the br_ioctl_mutex. This was also quite strange to me, since on the
surface it definitely looked like a deadlock, but the strict locking
order as I described previously should prevent any deadlocks from
happening.

Anyways, I decided to test switching up the lock order, since both the
refcnt warning and the task stall seemed closely related to the above
mentioned locks. When I ran the reproducer again after the patch, both
the warning and the stall issue went away. So I guess the patch is
still relevant in preventing bugs in some extreme cases -- although the
scenario created by the reproducer would probably never happen in real
usages?

Please let me know whether you have any thoughts on how the above
issues were triggered, and what other information I could gather to
further demystify this bug. Thank you again for your help!

Best regards,
Ziqi

