Return-Path: <netdev+bounces-57782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E48E8814201
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 07:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F0F1F225FB
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 06:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540DBD27A;
	Fri, 15 Dec 2023 06:54:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF523D268
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:57750)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rE1c8-00H4ys-S0; Thu, 14 Dec 2023 23:24:01 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:42120 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rE1c7-00BFOK-NB; Thu, 14 Dec 2023 23:24:00 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>,  Linux Network Development Mailing List
 <netdev@vger.kernel.org>,  "David S . Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Flavio
 Crisciani <fcrisciani@google.com>,  "Theodore Y. Ts'o" <tytso@google.com>,
  Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20231210111033.1823491-1-maze@google.com>
	<ebf480701cd22da00c89c5b1b00d31be95ff8e4d.camel@redhat.com>
	<CANP3RGfk6PqR2P8HnGX92ODnf6V5iKb+_zjonOsTDOB-3odM5g@mail.gmail.com>
Date: Fri, 15 Dec 2023 00:23:28 -0600
In-Reply-To: <CANP3RGfk6PqR2P8HnGX92ODnf6V5iKb+_zjonOsTDOB-3odM5g@mail.gmail.com>
	("Maciej =?utf-8?Q?=C5=BBenczykowski=22's?= message of "Thu, 14 Dec 2023
 14:17:44 +0100")
Message-ID: <87msuc3rxb.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1rE1c7-00BFOK-NB;;;mid=<87msuc3rxb.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/q7s1S1/htgoiBdpKAMbLeF0X4fUVekgo=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: ***
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4765]
	*  0.7 XMSubLong Long Subject
	*  2.5 XMGppyBdWords BODY: Gappy or l33t words
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?***;Maciej =c5=bbenczykowski <maze@google.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 571 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 12 (2.0%), b_tie_ro: 10 (1.8%), parse: 1.40
	(0.2%), extract_message_metadata: 7 (1.3%), get_uri_detail_list: 4.6
	(0.8%), tests_pri_-2000: 3.6 (0.6%), tests_pri_-1000: 2.6 (0.4%),
	tests_pri_-950: 1.21 (0.2%), tests_pri_-900: 0.97 (0.2%),
	tests_pri_-90: 69 (12.2%), check_bayes: 68 (11.9%), b_tokenize: 12
	(2.1%), b_tok_get_all: 13 (2.3%), b_comp_prob: 4.6 (0.8%),
	b_tok_touch_all: 35 (6.1%), b_finish: 0.89 (0.2%), tests_pri_0: 451
	(79.0%), check_dkim_signature: 0.59 (0.1%), check_dkim_adsp: 2.9
	(0.5%), poll_dns_idle: 1.12 (0.2%), tests_pri_10: 3.0 (0.5%),
	tests_pri_500: 9 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] net: sysctl: fix edge case wrt. sysctl write access
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Maciej =C5=BBenczykowski <maze@google.com> writes:

> On Thu, Dec 14, 2023 at 10:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
>>
>> On Sun, 2023-12-10 at 03:10 -0800, Maciej =C5=BBenczykowski wrote:
>> > The clear intent of net_ctl_permissions() is that having CAP_NET_ADMIN
>> > grants write access to networking sysctls.
>> >
>> > However, it turns out there is an edge case where this is insufficient:
>> > inode_permission() has an additional check on HAS_UNMAPPED_ID(inode)
>> > which can return -EACCES and thus block *all* write access.
>> >
>> > Note: AFAICT this check is wrt. the uid/gid mapping that was
>> > active at the time the filesystem (ie. proc) was mounted.
>> >
>> > In order for this check to not fail, we need net_ctl_set_ownership()
>> > to set valid uid/gid.  It is not immediately clear what value
>> > to use, nor what values are guaranteed to work.
>> > It does make sense that /proc/sys/net appear to be owned by root
>> > from within the netns owning userns.  As such we only modify
>> > what happens if the code fails to map uid/gid 0.
>> > Currently the code just fails to do anything, which in practice
>> > results in using the zeroes of freshly allocated memory,
>> > and we thus end up with global root.
>> > With this change we instead use the uid/gid of the owning userns.
>> > While it is probably (?) theoretically possible for this to *also*
>> > be unmapped from the /proc filesystem's point of view, this seems
>> > much less likely to happen in practice.
>> >
>> > The old code is observed to fail in a relatively complex setup,
>> > within a global root created user namespace with selectively
>> > mapped uid/gids (not including global root) and /proc mounted
>> > afterwards (so this /proc mount does not have global root mapped).
>> > Within this user namespace another non privileged task creates
>> > a new user namespace, maps it's own uid/gid (but not uid/gid 0),
>> > and then creates a network namespace.  It cannot write to networking
>> > sysctls even though it does have CAP_NET_ADMIN.
>>
>> I'm wondering if this specific scenario should be considered a setup
>> issue, and should be solved with a different configuration? I would
>> love to hear others opinions!

It feels like a setup issue to me.  A different mount of proc can
always be used to set the sysctls if really needed.

>
> While it could be fixed in userspace.  I don't think it should:
>
> The global root uid/gid are very intentionally not mapped in (as a
> security feature).
> So that part isn't changeable (it's also a system daemon and not under
> user control).

Likewise the default for all sysctls is global uid 0 and global gid 0.

> The user namespace very intentionally maps uid->uid and not 0->uid.
> Here there's theoretically more leeway... because it is at least under
> user control.
> However here this is done for good reason as well.
> There's plenty of code that special cases uid=3D0, both in the kernel
> (for example capability handling across exec) and in various userspace
> libraries.  It's unrealistic to fix them all.

Ish.  Frankly in the kernel I have fixed them all a long time ago.
At least when the uids don't map straight through.

At least in the case when they don't make to the global uid 0 and global
gid 0.

> Additionally it's nice to have semi-transparent user namespaces,
> which are security barriers but don't remap uids - remapping causes confu=
sion.
> (ie. the uid is either mapped or not, but if it is mapped it's a 1:1 mapp=
ing)

Ah.  So you are deliberately creating a this setup.

> As for why?  Because uids as visible to userspace may leak across user
> namespace boundaries,
> either when talking to other system daemons or when talking across machin=
es.
> It's pretty easy (and common) to have uids that are globally unique
> and meaningful in a cluster of machines.
> Again, this is *theoretically* fixable in userspace, but not actually
> a realistic expectation.
>
> btw. even outside of clusters of machines, I also run some
> user/uts/net namespace using
> code on my personal desktop (this does require some minor hacks to
> unshare/mount binaries),
> and again I intentionally map uid->uid and 0->uid, because this makes
> my username show up as 'maze' and not 'root'.
>
> This is *clearly* a kernel bug that this doesn't just work.

No it is not *clearly* bug.

If the owning uid/gid is not mapped it is in general not safe to write
to an inode.  It is a nonsense scenario.

You have deliberately created a scenario where there is no uid 0 or
gid 0 to deliberately break things as a security feature and then you
are asking why things break?

As far as I can tell this is like locking your keys in the car, to make
certain no one can steal your car.  It works but it also makes it
difficult to get into your car and drive it.

> (side note: there's a very similar issue in proc_net.c which I haven't
> gotten around to fixing yet, because it looks to be more complex to
> convince oneself it's safe to do)

It is not a some much similar as the same.

Among other things there is a possibility that someone else has
deliberately used the inability to write to those sysctls without
the 0 uid and gid mapped.  If this is the case you are busy breaking
someone else's security.

As I recall the classic approach on nfs is to map uid 0 to a useless uid
like nobody.  I don't understand why something like that is not being
used in your case.

I don't see how deliberately crippling yourself by leaving 0 completely
unmapped gains anything of any value.  As such I don't understand
why you would like the kernel to have a special case to support your
use case.

Eric

