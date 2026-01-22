Return-Path: <netdev+bounces-252240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AIWHmnccWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:14:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB84E62E34
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 839B550641B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1845480DC4;
	Thu, 22 Jan 2026 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xeh+59Vb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8BE480329
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069289; cv=pass; b=e2o7Br1Yh47eYNqtm38F11FFPqHy3Al3xFA2lp4+nEq+KLqQj3kBpex8tDCRs6Ly7XTEWVdYtYuwp7GGd9NZIbdjPAR1uotOmXPd6L7Oc1my3DTla0Qjfu1cS0c9VGE1fqHILqXGrqv7mLfTYvJMxkdBPO/VTZ4ptuNX2X0Fpfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069289; c=relaxed/simple;
	bh=WlN4hzuF8vTi5+ApYD5N28/NEvlDvu0RzyXY+q6dasA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppyXg/1nHHrcSITjV7RIcUM0Vx7cQPUZYD8Wf8OfVE8vjNJx10f5vi2XuJ0lXteGcULrw66uW2eZDg7rv4Dc9eUpfPnvtqUVBh55Vx9r8BGWqF3ZSKU5S6KTqvSue7qMY0EjQ5bCFr5FRussWXPXrCJr8W/xxdPFR/z8OFlOfo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xeh+59Vb; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50143fe869fso7718811cf.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:08:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769069283; cv=none;
        d=google.com; s=arc-20240605;
        b=TeObXOWcgovDjAk/NuE3Ypv5u4sLB4TfRiqJ4M8JdNskr+9sn8BFB4TX6sySB7T/6T
         kBsE7jdVAGRMhrT/KnysnOkME8KiOQ0mASYjZ4mJOYKfcp3mtiUsqqsLbckCyjV5bNOX
         ZoEG7ZG9+XLN7kpqtzdI5Log5VHHMnxoS7Q+JRM9lK9gYdTNBfeAnVc4CWlYLcpGgrlT
         /IpFjLgPzokkylDH4eeQr37Xob92uLnlpQK2Xag77qlBHljLpPHmQNgLJg+pdvrEF+NM
         Z23gytbm7wFSRIQkTe5OrX6fbFu/SDDUr8Yr9VimutRfOLOwI0d1jozqhxOcTLZFmQOp
         R3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2KiDv+PvaegYWelARUldxBAuAsWb5iha788hipdQpzw=;
        fh=RLxTI/iaP9MIkmN+DCL5K9N8ejau5lR1f39DWp3LZao=;
        b=Pmdvz6uLUJvJpNLnSXn4x5klB4HZzU9nNxWMN9eWw29SsAlWKn+LWXKXZ2WqKvtTTn
         bNO5+qXNdNRG4XNX/scrL4kSnM3a34C50YUBPNGh83UVMQ4V7nqZu9/vkp9WVvyawqLE
         134AzShQ2GsZiYjCzoLJjm6KClTQrU9YpFKt9ASGyAedL3rtW3shS2J8PU0h7sTbqDNr
         45Ee1TAz4eCrIQbdkmoKuBcAd7oCCDvBR73hAD493nOhcgbMHMyD3VgnCCd6zParFYwr
         WAUsL1DmJyOnkQDfGU+01WgHyw3LixmOiWpE+axQ8Ty7gf2xtTqCeYopYJj+uxed8eH2
         ZeIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769069283; x=1769674083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KiDv+PvaegYWelARUldxBAuAsWb5iha788hipdQpzw=;
        b=xeh+59VbU6vPx0AbOcopb29doHAAO0XU1OzSrPRoLnER492Xw00+knfIY32iVtt3QR
         IpR/BsquX1xVIcO4tXrT4eLcqMPUfNd2xAQ9P5x7abkL1lM+bnYd/Nv9+YROqrrztufq
         L0xZYTZf604u92W+vdRAcrIK+OtTJtQbE0w+iQTPRL7P1jBmvO59kCarMvrIkONb6Tkj
         cudniAgh753shLnN/WckDEry9CfE23zbMVZwbyIgy9CUo28U6q3QUmsX8bi6iw9AZCb+
         ohTrP5wA4HjCN0KtgiAihPP5+d0mDJXbwb/S2PXI+tvAGqy7MW7y9k2O0ON/+42ln6Ma
         PntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769069283; x=1769674083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2KiDv+PvaegYWelARUldxBAuAsWb5iha788hipdQpzw=;
        b=M4aRl6No8yDRQ5toux3vH4ko8rX6b8yib+76UZELSPBW9GZ1R3r9DphnfStbQyRY7v
         O5gp2KQmw5Udhk56qOj9Cinn4AXJeFZ9ty8gu6DNCwC2MD/gK/g5kiXxta7gpR3COevK
         m94uZFKkwi0kXQbJUNg7xcjKPhu87iJl2NFjWyYxbSb6c7XSGWkCMTgFcQqyHnbXyUqa
         yF9Ok2mCB7rt6IoIczfVjkxRicINUiPiMHGN7melQeM0RNIp5adtjJP2/wDYPROQrX76
         0Af1qFFgMZoHIds7FH4or6OBcPBpTXe3r4ZSc4c124A0hZeObKnoADhGOkFaUARzMei5
         QDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqti3xnVDgTiGzYUvyj84lqBDxipeExxGkK8tVp3F++LweNWwTJGv+zBvQkHq3dmoNGxs2Zks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KcnkBVLEvyzhWQ76CyP9lszQt1Wt59XxY8QIoAXZNr5RoNHD
	ISPIV1crwmL6A+q6L+en//PwF8svS7bRp/Bs6ZOA1nzXsBKb7DZLHj11XpjVwbHaSq/ohfZPEBK
	rJAQSFq7GpZGHhXBlEEOVHktuSx7P3GTob5dXstS5
X-Gm-Gg: AZuq6aI84HWbNY0eS5G5VUV3J/cpL3OEN71PHzm4OpoD3xql1ysa2PDSMYjDLxsKaQU
	4qhvfaYZxN1sTwiIvPKeEbWn1PahxjH4H7Sn9B/HwXngi/Rqw0q/0ejRWAxvmbCbO2efEvjLhfa
	XwVs0NCdS6EOnQXnqJqHU0O6/gq/utAWnc2t7RDdjfIAXbG0yJ4Zx8KWQMbGroLPH99q4Gy4a2q
	O5rmb78Z0HRf8/4vw0yWL31bkD0dvMcRJgKhXR7+Ck1zIKNbjjf45EOS+W+8+HZM0VOTPM=
X-Received: by 2002:a05:622a:38a:b0:4e8:838d:1992 with SMTP id
 d75a77b69052e-502a16f6e6emr279226971cf.63.1769069282947; Thu, 22 Jan 2026
 00:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <39db9ec8.c5b0.19be4b4a8d5.Coremail.baishuoran@hrbeu.edu.cn>
In-Reply-To: <39db9ec8.c5b0.19be4b4a8d5.Coremail.baishuoran@hrbeu.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jan 2026 09:07:52 +0100
X-Gm-Features: AZwV_QhaNJETCE35YZN06w96xw2e1qsh_aMdlEXsanYydS9Tv3-zxvYeGmVo4sY
Message-ID: <CANn89iKi6tyaM_0HPu4SsCE1M8tzXB_VvkEyz-27PM9u-1dMVQ@mail.gmail.com>
Subject: Re: hung task in rtnl_newlink
To: =?UTF-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Kun Hu <huk23@m.fudan.edu.cn>, 
	Jiaji Qin <jjtan24@m.fudan.edu.cn>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_FROM(0.00)[bounces-252240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,fudan.edu.cn:email,hrbeu.edu.cn:email]
X-Rspamd-Queue-Id: DB84E62E34
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 8:56=E2=80=AFAM =E7=99=BD=E7=83=81=E5=86=89 <baishu=
oran@hrbeu.edu.cn> wrote:
>
> Dear Maintainers,
>
>
> When using our customized Syzkaller to fuzz the latest Linux kernel, the =
following crash was triggered.
>
>
> HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> git tree: upstream
> Output:https:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/9%2=
0hung%20task%20in%20rtnl_newlink/report9.txt
> Kernel config: https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc=
7_todo/config.txt
> C reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/9%2=
0hung%20task%20in%20rtnl_newlink/9repro.txt
> Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0702_6=
.14/9%20hung%20task%20in%20rtnl_newlink/9repro.c
>
> The hung-task is primarily associated with the linkwatch workqueue callba=
ck. Specifically, linkwatch_event() processes batches of devices while hold=
ing RTNL (rtnl_lock()), during which it repeatedly invokes linkwatch_do_dev=
() and further calls paths such as dev_activate(), dev_deactivate(), and ne=
tdev_state_change(), which may involve relatively time-consuming or blockin=
g operations (link_watch.c:285=E2=80=93287, 194=E2=80=93254, 166=E2=80=9318=
7). At the same time, messages sent from userspace via sendmsg enter the ke=
rnel synchronously through netlink_unicast_kernel() in af_netlink.c (af_net=
link.c:1312) and are handled in the protocol callback invoked from netlink_=
rcv_skb() (af_netlink.c:2533). As a result, when RTNL is held by linkwatch =
for an extended period, a large number of rtnetlink requests may block whil=
e attempting to acquire RTNL, enter the D state, and eventually trigger hun=
g-task reports.
> We have reproduced this issue several times on 6.19-rc4 again.
>
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.ed=
u.cn>, Shuoran Bai <baishuoran@hrbeu.edu.cn>
>

Note : This problem has been reported many times by syzbot.

Also, the following trace is not really helpful.

You should use scripts/decode_stacktrace.sh on it.

>>
> [  579.240159][   T46]  </TASK>
> [  579.241133][   T46] INFO: task syz-executor:10690 blocked for more tha=
n 183 seconds.
> [  579.243486][   T46]       Not tainted 6.19.0-rc4 #1
> [  579.245045][   T46] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=
 disables this message.
> [  579.247776][   T46] task:syz-executor    state:D stack:11296 pid:10690=
 tgid:10690 ppid:1      task_flags:0x400140 flags:0x00080002
> [  579.251394][   T46] Call Trace:
> [  579.252443][   T46]  <TASK>
> [  579.253371][   T46]  __schedule+0xe62/0x1fa0
> [  579.254791][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.256666][   T46]  ? schedule+0xb6/0xe0
> [  579.258063][   T46]  schedule+0x34/0xe0
> [  579.259368][   T46]  schedule_preempt_disabled+0xf/0x20
> [  579.261101][   T46]  __mutex_lock+0x810/0x1240
> [  579.262603][   T46]  ? __sanitizer_cov_trace_pc+0x1c/0x50
> [  579.264341][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.266153][   T46]  ? rtnl_newlink+0x4cb/0x760
> [  579.267639][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.269590][   T46]  ? rtnl_newlink+0x4cb/0x760
> [  579.271070][   T46]  rtnl_newlink+0x4cb/0x760
> [  579.272516][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.274280][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.276178][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.277919][   T46]  ? __pfx_rtnl_newlink+0x10/0x10
> [  579.279488][   T46]  rtnetlink_rcv_msg+0x6af/0xae0
> [  579.281023][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.282754][   T46]  ? __sanitizer_cov_trace_pc+0x1c/0x50
> [  579.284506][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.286346][   T46]  ? ref_tracker_free+0x157/0x2e0
> [  579.287958][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.289777][   T46]  netlink_rcv_skb+0x7d/0x1c0
> [  579.291270][   T46]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [  579.293003][   T46]  netlink_unicast+0x2bc/0x3d0
> [  579.294555][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.296425][   T46]  netlink_sendmsg+0x340/0x690
> [  579.298010][   T46]  __sock_sendmsg+0x11b/0x130
> [  579.299505][   T46]  __sys_sendto+0x18d/0x210
> [  579.301045][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.302777][   T46]  ? xfd_validate_state+0x3b/0xe0
> [  579.304392][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.306225][   T46]  ? __sanitizer_cov_trace_pc+0x1c/0x50
> [  579.307979][   T46]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  579.309720][   T46]  ? write_comp_data+0x29/0x80
> [  579.311228][   T46]  __x64_sys_sendto+0x26/0x30
> [  579.312726][   T46]  do_syscall_64+0xc3/0x11e0
> [  579.314233][   T46]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  579.316176][   T46] RIP: 0033:0x7f947bd1ee04
> [  579.317561][   T46] RSP: 002b:00007ffca283d060 EFLAGS: 00000293 ORIG_R=
AX: 000000000000002c
> [  579.320127][   T46] RAX: ffffffffffffffda RBX: 00007f947cad4620 RCX: 0=
0007f947bd1ee04
> [  579.322503][   T46] RDX: 000000000000002c RSI: 00007f947cad4670 RDI: 0=
000000000000003
> [  579.324925][   T46] RBP: 0000000000000000 R08: 00007ffca283d0bc R09: 0=
00000000000000c
> [  579.327410][   T46] R10: 0000000000000000 R11: 0000000000000293 R12: 0=
0000000000000
>
> thanks,
> Kun Hu

