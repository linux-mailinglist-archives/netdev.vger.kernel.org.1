Return-Path: <netdev+bounces-39296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB97BEBA2
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2910A1C20A92
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705411D53B;
	Mon,  9 Oct 2023 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04BA3FB2B
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:33:11 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A25A7
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:33:10 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:37442)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qpww8-004ZaS-9w; Mon, 09 Oct 2023 14:33:08 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:35936 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qpww7-008J2v-1U; Mon, 09 Oct 2023 14:33:07 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: David Ahern <dsahern@gmail.com>,  Stephen Hemminger
 <stephen@networkplumber.org>,  netdev@vger.kernel.org,  Nicolas Dichtel
 <nicolas.dichtel@6wind.com>,  Christian Brauner <brauner@kernel.org>,
  David Laight <David.Laight@ACULAB.COM>
References: <20231009182753.851551-1-toke@redhat.com>
Date: Mon, 09 Oct 2023 15:32:44 -0500
In-Reply-To: <20231009182753.851551-1-toke@redhat.com> ("Toke
	=?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen=22's?= message of "Mon, 9 Oct 2023
 20:27:48 +0200")
Message-ID: <877cnvtu37.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1qpww7-008J2v-1U;;;mid=<877cnvtu37.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18TcwXxFpTStmUkkHlZogAVTG0ddN3d3Lw=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?;Toke H=c3=b8iland-J=c3=b8rgensen <toke@redhat.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 695 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 9 (1.3%), b_tie_ro: 7 (1.1%), parse: 1.51 (0.2%),
	extract_message_metadata: 7 (0.9%), get_uri_detail_list: 3.5 (0.5%),
	tests_pri_-2000: 5.0 (0.7%), tests_pri_-1000: 4.1 (0.6%),
	tests_pri_-950: 1.90 (0.3%), tests_pri_-900: 1.54 (0.2%),
	tests_pri_-200: 1.34 (0.2%), tests_pri_-100: 5 (0.8%), tests_pri_-90:
	151 (21.7%), check_bayes: 148 (21.2%), b_tokenize: 13 (1.9%),
	b_tok_get_all: 8 (1.1%), b_comp_prob: 4.3 (0.6%), b_tok_touch_all: 118
	(17.0%), b_finish: 0.96 (0.1%), tests_pri_0: 481 (69.3%),
	check_dkim_signature: 0.80 (0.1%), check_dkim_adsp: 2.9 (0.4%),
	poll_dns_idle: 0.46 (0.1%), tests_pri_10: 2.3 (0.3%), tests_pri_500:
	10 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> The 'ip netns' command is used for setting up network namespaces with per=
sistent
> named references, and is integrated into various other commands of iprout=
e2 via
> the -n switch.
>
> This is useful both for testing setups and for simple script-based namesp=
acing
> but has one drawback: the lack of persistent mounts inside the spawned
> namespace. This is particularly apparent when working with BPF programs t=
hat use
> pinning to bpffs: by default no bpffs is available inside a namespace, and
> even if mounting one, that fs disappears as soon as the calling
> command exits.

It would be entirely reasonable to copy mounts like /sys/fs/bpf from the
original mount namespace into the temporary mount namespace used by
"ip netns".

I would call it a bug that "ip netns" doesn't do that already.

I suspect that "ip netns" does copy the mounts from the old sysfs onto
the new sysfs is your entire problem.

Or is their a reason that bpffs should be per network namespace?=20

> The underlying cause for this is that iproute2 will create a new mount na=
mespace
> every time it switches into a network namespace. This is needed to be abl=
e to
> mount a /sys filesystem that shows the correct network device information=
, but
> has the unfortunate side effect of making mounts entirely transient for a=
ny 'ip
> netns' invocation.

Mount propagation can be made to work if necessary, that would solve the
transient problem.=20

> This series is an attempt to fix this situation, by persisting a mount na=
mespace
> alongside the persistent network namespace (in a separate directory,
> /run/netns-mnt). Doing this allows us to still have a consistent /sys ins=
ide
> the namespace, but with persistence so any mounts survive.

I really don't like that direction.

"ip netns" was designed and really should continue to be a command that
makes the world look like it has a single network namespace, for
compatibility with old code.  Part of that old code "ip netns" supports
is "ip" itself.

I think you are making bpffs unnecessarily per network namespace.

> This mode does come with some caveats. I'm sending this as RFC to get fee=
dback
> on whether this is the right thing to do, especially considering backwards
> compatibility. On balance, I think that the approach taken here of
> unconditionally persisting the mount namespace, and using that persistent
> reference whenever it exists, is better than the current behaviour, and t=
hat
> while it does represent a change in behaviour it is backwards compatible =
in a
> way that won't cause issues. But please do comment on this; see the patch
> description of patch 4 for details.

As I understand it this will cause a problem for any application that
is network namespace aware and does not use "ip netns" to wrap itself.

I am fairly certain that pinning the mount namespace will result in
never seeing an update of /etc/resolve.conf.  At least if you
are on a system that has /etc/netns/NAME/resolve.conf

Unless I am missing something I think you are trying to solve the wrong
problem.  I think all it will take is for the new mount of /sys to have
the same mounts on it as the previous mount of /sys.

Eric

